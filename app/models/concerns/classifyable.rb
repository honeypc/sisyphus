# frozen_string_literal: true

module Classifyable
  extend ActiveSupport::Concern

  FIELD_TYPES = {
    boolean: 'toggle',
    date: 'text',
    datetime: 'text',
    enum: 'select',
    float: 'float',
    integer: 'text',
    time: 'text',
    text: 'textarea',
    string: 'text',
    uuid: 'text',
    has_one: 'select',
    has_many: 'select',
    polymorphic: 'select',
    belongs_to: 'select'
  }.freeze

  DEFAULT_FIELD_TYPE = 'text'
  READ_ONLY_ATTRIBUTES = %w[id created_at updated_at deleted_at classify ancentry].freeze

  def self.included(klass)
    klass.extend ClassMethods
    klass.class_eval do

      default_scope { subclass? && classify? ? where(classify: self.model.to_s) : nil }

      before_validation :set_classify, if: -> { respond_to?(:classify) }
      before_validation :set_creator, if: -> { respond_to?(:creator_id) }

      private

      def set_classify
        self.classify ||= self.class.to_s
      end

      def set_creator
        if respond_to?(:parent) && parent.present?
          self.creator ||= parent.creator || Current.user
        else
          self.creator ||= Current.user
        end
      end
    end
  end

  module ClassMethods
    def klass
      ancestors.first
    end

    def classify?
      klass.column_names.include?('classify')
    end

    def ancestry?
      klass.column_names.include?('ancestry')
    end

    def subclass?
      klass.superclass < ActiveRecord::Base && klass.table_name == klass.superclass.table_name
    end

    def subklasses
      @subklasses ||= AnnotateModels.send(:get_model_files, { is_rake: true }).sort_by{ |f| f.join.size }.map do |file|
        subklass = AnnotateModels.send(:get_model_class, File.join(file))
        subklass if subklass < klass
      end.compact
    end

    def has_ancestry_classify
      subklasses.each do |subklass|
        method_name = subklass.name.split('::').last.parameterize.underscore.tableize

        scope method_name.to_sym, -> { where(classify: subklass.name) }

        attr_accessor method_name.to_sym

        unless respond_to?(:method_name)
          define_method method_name do
            if records = instance_variable_get("@#{method_name}")
              records
            else
              subklass.where(id: children.pluck(:id))
            end
          end
        end

        define_method "#{method_name.singularize}_ids" do
          send(method_name).map(&:id)
        end

        define_method "#{method_name}=" do |params|
          records = []
          if params.is_a?(Hash)
            records = params.map do |record_id, param|
              record = subklass.where("id = ? OR id = ?", record_id, param.dig(:id)).first
              record ||= subklass.new(param)
              record.parent = self
              record
            end
          elsif params.is_a?(Array)
            records = params.map do |param|
              record = subklass.find_by(id: param.dig(:id)) if param.dig(:id)
              record ||= subklass.new(param)
              record.parent = self
              record
            end.compact
          end
          instance_variable_set("@#{method_name}", records)
        end

        define_method "save_#{method_name}" do
          return unless (records = instance_variable_get("@#{method_name}"))
          records.map(&:save)
        end
      end

      define_method "save_ancestry_classifies" do
        self.class.subklasses.each do |subklass|
          method_name = subklass.name.split('::').last.parameterize.underscore.tableize
          send("save_#{method_name}")
        end
      end

      after_save :save_ancestry_classifies
    end

    def fields
      @fields ||= attributes.map do |attribute|
        [attribute, {
          key: attribute,
          name: human_attribute_name(attribute),
          data_type: column_type_for_attribute(attribute),
          input_type: field_type(attribute),
          get_method: attribute,
          set_method: attribute
        }]
      end.to_h
    end

    def to_columns
      @columns ||= fields.values
    end

    def attributes
      attrs = (
        klass.reflections.keys +
        klass.columns.map(&:name) -
        redundant_attributes
      )

      primary_key = attrs.delete(klass.primary_key)
      created_at = attrs.delete("created_at")
      updated_at = attrs.delete("updated_at")

      [
        primary_key,
        *attrs.sort,
        created_at,
        updated_at,
      ].compact
    end

    def redundant_attributes
      klass.reflections.keys.flat_map do |relationship|
        redundant_attributes_for(relationship)
      end.compact
    end

    def redundant_attributes_for(relationship)
      case association_type(relationship)
      when :polymorphic
        [relationship + "_id", relationship + "_type"]
      when :belongs_to
        relationship + "_id"
      end
    end

    def field_type(attribute)
      type = column_type_for_attribute(attribute.to_s)

      if type
        FIELD_TYPES.fetch(type, DEFAULT_FIELD_TYPE)
      else
        association_type(attribute)
      end
    end

    def column_type_for_attribute(attr)
      if enum_column?(attr)
        :enum
      else
        column_types(attr)
      end
    end

    def enum_column?(attr)
      klass.respond_to?(:defined_enums) &&
      klass.defined_enums.keys.include?(attr)
    end

    def column_types(attr)
      klass.columns.find { |column| column.name == attr }.try(:type)
    end

    def association_type(attribute)
      return :string unless relationship = klass.reflections[attribute.to_s]

      if relationship.has_one?
        :has_one
      elsif relationship.collection?
        :has_many
      elsif relationship.polymorphic?
        :polymorphic
      else
        :belongs_to
      end
    end
  end

  module InstanceMethods
    def classify?
      return false if respond_to?(:classify)

      classify.blank?
    end

    def serializer_attributes
      @serializer_attributes ||= self.class.fields.each do |attribute, options|
      end
    end
  end
end

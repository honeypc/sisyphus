# frozen_string_literal: true

# TranslationConcern
module Translateable
  extend ActiveSupport::Concern

  DEFAULT_TRANSLATE_FIELDS = {
    slug: :string,
    title: :tring,
    description: :tinytext,
    body: :longtext,
    dataset: :jsonb
  }
  DEFAULT_TRANSLATE_COLUMNS = DEFAULT_TRANSLATE_FIELDS.keys

  def self.included(klass)
    klass.extend ClassMethods

    klass.class_eval do
      include InstanceMethods

      class_attribute :translated_attribute_rich_texts, default: []

      translates *DEFAULT_TRANSLATE_COLUMNS
      if klass.respond_to?(:translated_attribute_names)
        after_create :init_default_locales, if: -> { self.class.respond_to?(:translated_attribute_names) }
      end
    end
  end

  # ClassMethods
  module ClassMethods
    def create_translation_table!(fields = {}, options = {})
      fields.merge(DEFAULT_TRANSLATE_FIELDS)
      super
    end

    def has_translate_rich_text(attribute)
      self.translated_attribute_rich_texts.push(attribute)
    end

    def rich_text_translates(*attr_names)
      temp_attr_names = attr_names.dup
      options = temp_attr_names.extract_options!
      self.translated_attribute_rich_texts += temp_attr_names

      translates(*attr_names)
    end

    def translates(*attr_names)
      options = attr_names.extract_options!

      if (rich_text_names = options.delete(:rich_texts))
        self.translated_attribute_rich_texts += rich_text_names
        attr_names = (attr_names + translated_attribute_rich_texts).uniq
      end

      super
      if translated_attribute_rich_texts
        init_translate_attribute_rich_texts

        translated_attribute_rich_texts.uniq.each do |attribute|
          delegate attribute.to_sym, to: :translation
          delegate "#{attribute}=".to_sym, to: :translation
        end
      end
    end

    def init_translate_attribute_rich_texts
      trans_class = const_get(:Translation, false)
      trans_class.class_eval do
        module_parent.translated_attribute_rich_texts.each do |attribute|
          has_rich_text attribute.to_sym
        end

        def self.ransackable_attributes(auth_object = nil)
          column_names + _ransackers.keys
        end

        def self.ransackable_associations(auth_object = nil)
          reflect_on_all_associations.map do |a|
            a.name.to_s unless a.name.to_s.end_with?('_translations')
          end.compact + _ransackers.keys
        end
      end
    end
  end

  # InstanceMethods
  module InstanceMethods
    def init_default_locales
      default_translate_attributes = init_default_translate_attributes

      (I18n.available_locales - [I18n.locale]).each do |locale|
        default_translate_attributes[:locale] = locale
        update(default_translate_attributes)
      end
    end

    def init_default_translate_attributes
      self.class.translated_attribute_names.map do |attribute|
        [attribute, send(attribute)]
      end.to_h
    end
  end
end

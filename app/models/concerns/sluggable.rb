# frozen_string_literal: true

# Sluggable Concern
module Sluggable
  extend ActiveSupport::Concern

  def self.included(klass)
    klass.extend ClassMethods
    klass.extend FriendlyId

    klass.class_eval do
      include InstanceMethods

      friendly_id :safe_slug, use: klass.slug_options
    end
  end

  # ClassMethods
  module ClassMethods
    def slug_options
      [:finders, :slugged].tap do |options|
        options.push(:globalize) if klass.respond_to?(:translated_attribute_names)
      end
    end
  end

  # InstanceMethods
  module InstanceMethods
    def safe_slug
      return title&.to_slug if respond_to?(:title)
      return name&.to_slug if respond_to?(:name)

      id
    end
  end
end

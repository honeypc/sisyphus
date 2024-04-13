module Jsonable
  extend ActiveSupport::Concern

  def self.included(klass)
    klass.extend ClassMethods

    klass.class_eval do
      include InstanceMethods
    end
  end

  module ClassMethods
    def serializer_attributes
      super || attributes
    end
  end

  module InstanceMethods
    def to_jb
      Jbuilder.new do |record|
        record.(self, *self.class.serializer_attributes)
      end
    end
  end
end

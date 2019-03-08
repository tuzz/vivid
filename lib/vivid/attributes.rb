module Vivid
  module Attributes
    def self.included(klass)
      klass.extend(ClassMethods)
    end

    def initialize(**params)
      params.each do |key, value|
        public_send(:"#{key}=", value)
      end
    end

    def attributes
      self.class.attribute_names.map do |name|
        [name, public_send(name)]
      end.to_h
    end

    module ClassMethods
      attr_reader :attribute_names

      def attributes(*names)
        @attribute_names ||= []
        @attribute_names += names

        attr_accessor(*names)
      end
    end
  end
end

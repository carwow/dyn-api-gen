# frozen_string_literal: true

module DynApiGen
  class Parameter
    attr_reader :name, :in, :required, :default

    def initialize(openapi_definition)
      @name, @in, @required = openapi_definition.fetch_values('name', 'in', 'required')
      @default = openapi_definition['default']
    end

    def header?
      @in == 'header'
    end

    def to_method_name
      @name.gsub(/(\[|\])/, '[' => '_', ']' => '').downcase
    end
  end
end

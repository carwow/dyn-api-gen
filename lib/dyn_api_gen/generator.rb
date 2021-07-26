# frozen_string_literal: true

module DynApiGen
  class Generator
    RequestDefinition = Struct.new(:namespace, :name, :verb, :path, :parameters)

    def initialize(openapi_path)
      @openapi_path = openapi_path
      @module = Module.new
    end

    def self.generate(path)
      new(path).generate
    end

    def generate
      requests = []

      openapi['paths'].each do |path, endpoints|
        endpoints.each do |verb, detail|
          name = to_underscore(detail.fetch('operationId'))
          parameters = detail.fetch('parameters').map(&Parameter.method(:new))

          detail.fetch('tags').each do |namespace|
            requests << RequestDefinition.new(to_camelcase(namespace), name, verb, path, parameters)
          end
        end
      end

      requests.group_by(&:namespace).each do |namespace, req_definitions|
        namespace_module = Module.new
        puts namespace
        req_definitions.each do |req_def|
          puts "> #{req_def.name}"
          namespace_module.define_singleton_method(req_def.name) do
            Request.new(req_def.to_h)
          end
        end

        @module.send(:const_set, namespace, namespace_module)
        # @module.const_set(namespace, namespace_module)
      end

      @module
    end

    private

    def openapi
      @openapi ||= YAML.load_file(@openapi_path)
    end

    def to_underscore(str)
      str.gsub(/(.)([A-Z])/, '\1_\2').downcase
    end

    def to_camelcase(str)
      str.split('_').map(&:capitalize).join
    end
  end
end

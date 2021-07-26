# frozen_string_literal: true

module DynApiGen
  class Request
    def initialize(**kwargs)
      @name, @verb, @path, @parameters =
        kwargs.fetch_values(:name, :verb, :path, :parameters)

      @with_params = {}
      @with_headers = {}

      create_with_methods!
      fill_default_headers
      fill_default_params
    end

    # Setthe headers to be used. It merges whatever is defined
    def with_headers(new_headers)
      @with_headers.merge!(new_headers)
      self
    end

    private

    # This method will generate the `with_*` instance methods dynamically,
    # to set the params needed by this request.
    def create_with_methods!
      @parameters.reject(&:header?).each do |parameter|
        self.class.define_method(:"with_#{parameter.to_method_name}") do |value|
          @with_params[parameter.name] = value
          self
        end
      end
    end

    def fill_default_headers
      @parameters.select { |p| p.header? && p.default }.each do |parameter|
        @with_headers[parameter.name] = parameter.default
      end
    end

    def fill_default_params
      @parameters.select { |p| !p.header? && p.default }.each do |parameter|
        @with_params[parameter.name] = parameter.default
      end
    end
  end
end

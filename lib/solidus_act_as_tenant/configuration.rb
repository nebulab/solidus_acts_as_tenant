# frozen_string_literal: true

module SolidusActAsTenant
  class Configuration
    attr_accessor :tenant_aware_models, :tenant_column_name, :acts_as_tenant_args, :class_name
  end

  class << self
    def configuration
      @configuration ||= Configuration.new
    end

    alias config configuration

    def configure
      yield configuration
    end
  end
end

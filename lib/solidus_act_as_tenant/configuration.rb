# frozen_string_literal: true

module SolidusActAsTenant
  class Configuration
    attr_accessor :tenant_aware_models
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

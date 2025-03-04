# frozen_string_literal: true

module SolidusActsAsTenant
  class Configuration
    attr_accessor :tenant_aware_models
    attr_writer :tenant_column_name, :acts_as_tenant_args, :class_name

    def tenant_column_name
      @tenant_column_name ||= :tenant_id
    end

    def acts_as_tenant_args
      @acts_as_tenant_args ||= [:tenant, { class_name: 'Spree::Tenant' }]
    end

    def class_name
      @class_name ||= 'Spree::Tenant'
    end
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

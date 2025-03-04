# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'

module SolidusActsAsTenant
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_acts_as_tenant'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    config.to_prepare do
      SolidusActsAsTenant::TenantAware.setup_tenant_aware_models
    end
  end
end

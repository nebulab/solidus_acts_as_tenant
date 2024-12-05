# frozen_string_literal: true

require 'solidus_core'
require 'solidus_support'

module SolidusActAsTenant
  class Engine < Rails::Engine
    include SolidusSupport::EngineExtensions

    isolate_namespace ::Spree

    engine_name 'solidus_act_as_tenant'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    config.after_initialize do
      SolidusActAsTenant::TenantAware.setup_tenant_aware_models
    end
  end
end

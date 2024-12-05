# frozen_string_literal: true

require 'pry'

RSpec.configure do |config|
  config.before(:each, set_tenant: true) do
    unless ::ActsAsTenant.current_tenant
      ::ActsAsTenant.current_tenant = Spree::Tenant.find_or_create_by!(name: 'Test')
    end
  end

  config.before(:suite, set_tenant: true) do
    unless ::ActsAsTenant.current_tenant
      ::ActsAsTenant.current_tenant = Spree::Tenant.find_or_create_by!(name: 'Test')
    end
  end

  config.after do
    ::ActsAsTenant.current_tenant = nil
  end
end

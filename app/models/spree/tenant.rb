# frozen_string_literal: true

if SolidusActAsTenant.config.class_name == 'Spree::Tenant'
  module Spree
    class Tenant < Spree::Base
      validates :name, presence: true, uniqueness: true
      validates :subdomain, uniqueness: true
      validates :domain, uniqueness: true
    end
  end
else
  class Tenant
    # No-op class definition
  end
end

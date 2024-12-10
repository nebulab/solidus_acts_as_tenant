# frozen_string_literal: true

module Spree
  class Tenant < Spree::Base
    if SolidusActAsTenant.config.class_name == 'Spree::Tenant'
      validates :name, presence: true, uniqueness: true
      validates :subdomain, uniqueness: true
      validates :domain, uniqueness: true
    end
  end
end

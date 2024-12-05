# frozen_string_literal: true

module Spree
  class Tenant < Spree::Base
    validates :name, presence: true, uniqueness: true
    validates :subdomain, uniqueness: true
    validates :domain, uniqueness: true
  end
end

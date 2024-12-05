# frozen_string_literal: true

module Spree
  class ProductsTaxon < Spree::Base
    acts_as_tenant :tenant
    belongs_to :product
    belongs_to :taxon
  end
end

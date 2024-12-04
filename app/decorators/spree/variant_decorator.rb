# frozen_string_literal: true

module SolidusActAsTenant
  module Spree
    module VariantDecorator
      # Fixes no method error related to validations added through acts_as_tenant
      def shipping_category_id
        super
      rescue NoMethodError
        product && product_shipping_category_id
      end

      def shipping_category
        super
      rescue NoMethodError
        product && product_shipping_category_id
      end

      ::Spree::Variant.prepend(self)
    end
  end
end

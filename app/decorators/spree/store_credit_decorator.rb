# frozen_string_literal: true

module SolidusActAsTenant
  module Spree
    module StoreCreditDecorator
      # Fixes no method error related to validations added through acts_as_tenant
      def payment_method_id
        super
      rescue NoMethodError
        nil
      end

      ::Spree::StoreCredit.prepend(self)
    end
  end
end

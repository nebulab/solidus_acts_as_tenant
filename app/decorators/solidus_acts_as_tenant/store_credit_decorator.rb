# frozen_string_literal: true

module SolidusActsAsTenant::StoreCreditDecorator # rubocop:disable Style/ClassAndModuleChildren
  # Fixes no method error related to validations added through acts_as_tenant
  def payment_method_id
    return if payment_method.nil?

    super
  end

  ::Spree::StoreCredit.prepend(self)
end

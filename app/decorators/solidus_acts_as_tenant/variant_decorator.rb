# frozen_string_literal: true

module SolidusActsAsTenant::VariantDecorator # rubocop:disable Style/ClassAndModuleChildren
  # Fixes errors related to validations added through acts_as_tenant

  def product_shipping_category_id
    return if product.nil?

    super
  end

  def product_shipping_category
    return if product.nil?

    super
  end

  def product_tax_category_id
    return if product.nil?

    super
  end

  def product_tax_category
    return if product.nil?

    super
  end

  ::Spree::Variant.prepend(self)
end

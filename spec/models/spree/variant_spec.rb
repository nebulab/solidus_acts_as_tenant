# frozen_string_literal: true

describe Spree::Variant, set_tenant: true do
  describe '#shipping_category' do
    let(:variant) { described_class.new }
    let(:shipping_category) { create(:shipping_category) }
    let(:product) { create(:product, shipping_category: shipping_category) }

    it 'returns nil for shipping_category when not set' do
      expect(variant.shipping_category).to be_nil
    end

    it 'returns nil for shipping_category_id when not set' do
      expect(variant.shipping_category_id).to be_nil
    end

    it 'returns the product shipping category when the variant shipping category is nil' do
      variant.product = product
      expect(variant.shipping_category).to eq(product.shipping_category)
    end

    it 'returns the product shipping category id when the variant shipping category is nil' do
      variant.product = product
      expect(variant.shipping_category_id).to eq(product.shipping_category_id)
    end

    it 'returns the correct shipping category id when the variant shipping category is set' do
      variant.shipping_category = shipping_category
      expect(variant.shipping_category_id).to eq(shipping_category.id)
    end

    it 'returns the correct shipping category when the variant shipping category is set' do
      variant.shipping_category = shipping_category
      expect(variant.shipping_category).to eq(shipping_category)
    end
  end
end

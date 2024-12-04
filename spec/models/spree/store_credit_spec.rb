# frozen_string_literal: true

describe Spree::StoreCredit, set_tenant: true do
  describe '#shipping_category' do
    let(:store_credit) { described_class.new }

    it 'does not raise an error when #payment_method_id is called' do
      expect { store_credit.payment_method_id }.not_to raise_error
    end

    it 'returns nil for #payment_method_id' do
      expect(store_credit.payment_method_id).to be_nil
    end
  end
end

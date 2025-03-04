# frozen_string_literal: true

RSpec.describe SolidusActsAsTenant do
  describe '.configuration' do
    it 'returns the same configuration instance' do
      expect(described_class.configuration).to eq(described_class.configuration)
    end

    it 'aliases config to configuration' do
      expect(described_class.config).to eq(described_class.configuration)
    end
  end

  describe '.configure' do
    it 'yields the configuration instance' do
      expect { |b| described_class.configure(&b) }.to yield_with_args(SolidusActsAsTenant::Configuration)
    end

    it 'allows configuring through a block' do
      described_class.configure do |config|
        config.tenant_column_name = :custom_tenant_id
      end

      expect(described_class.configuration.tenant_column_name).to eq(:custom_tenant_id)
    end
  end
end

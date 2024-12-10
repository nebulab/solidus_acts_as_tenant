# frozen_string_literal: true

RSpec.describe SolidusActAsTenant::Configuration do
  let(:configuration) { described_class.new }

  describe 'default values' do
    it 'has default tenant_column_name' do
      expect(configuration.tenant_column_name).to eq(:tenant_id)
    end

    it 'has default acts_as_tenant_args' do
      expect(configuration.acts_as_tenant_args).to eq([:tenant, { class_name: 'Spree::Tenant' }])
    end

    it 'has default class_name' do
      expect(configuration.class_name).to eq('Spree::Tenant')
    end
  end

  describe 'custom configuration' do
    it 'allows setting tenant_aware_models' do
      models = ['Spree::Product', 'Spree::Order']
      configuration.tenant_aware_models = models
      expect(configuration.tenant_aware_models).to eq(models)
    end

    it 'allows setting tenant_column_name' do
      configuration.tenant_column_name = :custom_tenant_id
      expect(configuration.tenant_column_name).to eq(:custom_tenant_id)
    end

    it 'allows setting acts_as_tenant_args' do
      custom_args = [:custom_tenant, { class_name: 'Custom::Tenant' }]
      configuration.acts_as_tenant_args = custom_args
      expect(configuration.acts_as_tenant_args).to eq(custom_args)
    end

    it 'allows setting class_name' do
      configuration.class_name = 'Custom::Tenant'
      expect(configuration.class_name).to eq('Custom::Tenant')
    end
  end
end

RSpec.describe SolidusActAsTenant do
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
      expect { |b| described_class.configure(&b) }.to yield_with_args(SolidusActAsTenant::Configuration)
    end

    it 'allows configuring through a block' do
      described_class.configure do |config|
        config.tenant_column_name = :custom_tenant_id
      end

      expect(described_class.configuration.tenant_column_name).to eq(:custom_tenant_id)
    end
  end
end

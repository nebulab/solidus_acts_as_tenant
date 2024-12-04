describe SolidusActAsTenant::TenantAware do
  describe '#setup_tenant_aware_models' do
    let!(:tenant) { Spree::Tenant.find_or_create_by!(name: 'Test') }
    let!(:tenant2) { create(:tenant, name: 'Test2') }

    SolidusActAsTenant.config.tenant_aware_models.each do |klass, validator_attributes|
      describe "for #{klass}" do
        it 'has a tenant accessor and the current tenant is already set', set_tenant: true do
          expect(klass.constantize.new.tenant).to eq tenant
        end

        validator_attributes.each do |attribute|
          it "validates uniqueness of #{attribute}", set_tenant: true do
            entry = create(klass.demodulize.underscore.downcase.to_sym, attribute => 'test@test.com')
            duplicate = entry.dup

            if klass == 'Spree::Product'
              duplicate.master = entry.master
              duplicate.slug = entry.slug
            end

            duplicate.valid?

            expect(duplicate.errors[attribute]).to include('has already been taken')
          end

          it 'allows duplicate values across different tenants' do
            ::ActsAsTenant.current_tenant = tenant
            entry = create(klass.demodulize.underscore.downcase.to_sym, attribute => 'test@test.com',
              tenant: tenant)
            duplicate = entry.dup

            if klass == 'Spree::Product'
              duplicate.master = entry.master
              duplicate.slug = entry.slug
            end

            ::ActsAsTenant.current_tenant = tenant2
            duplicate.tenant = tenant2
            duplicate.valid?

            expect(duplicate.errors[attribute]).to be_empty
          end
        end
      end
    end
  end
end

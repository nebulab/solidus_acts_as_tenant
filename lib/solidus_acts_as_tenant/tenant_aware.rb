# frozen_string_literal: true

module SolidusActsAsTenant
  # TenantAware automatically adds multi-tenant support to models
  # by adding tenant scoping and updating uniqueness validations to be tenant-aware.
  module TenantAware
    class << self
      def setup_tenant_aware_models
        tenant_aware_models = SolidusActsAsTenant.config.tenant_aware_models || []

        tenant_aware_models.each do |klass, validator_attributes|
          Module.new do
            @validator_attributes = validator_attributes
            define_singleton_method(:prepended) do |base|
              options = ::SolidusActsAsTenant.config.acts_as_tenant_args
              base.acts_as_tenant(*options[0..-2], **options.last)

              @validator_attributes&.each do |attribute|
                TenantAware.update_uniqueness_validation(base, attribute)
              end
            end

            klass.constantize.prepend(self)
          end
        end
      end

      def update_uniqueness_validation(base, attribute)
        attribute = attribute.to_sym
        validator = base._validators[attribute].find { _1.kind == :uniqueness }
        raise "No uniqueness validator found for #{attribute} on #{base}" unless validator

        new_options = validator.options.dup
        new_options[:scope] = Array(new_options[:scope]).push(::SolidusActsAsTenant.config.tenant_column_name)

        remove_existing_validation(base, attribute)
        base.validates_uniqueness_of attribute, **new_options
      end

      def remove_existing_validation(base, attribute)
        base._validators[attribute].reject! { _1.kind == :uniqueness }
        base._validate_callbacks.each do |callback|
          next unless callback.filter.try(:attributes)&.include?(attribute) &&
                      callback.filter.kind == :uniqueness

          callback.filter.attributes.delete(attribute)
        end
      end
    end
  end
end

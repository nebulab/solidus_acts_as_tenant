# frozen_string_literal: true

SolidusActsAsTenant.configure do |config|
  # This configuration is used to dynamically prepend existing models with the acts_as_tenant concern.
  # See the tenant_aware_classes.yml file for inormation on how to configure this file.
  config.tenant_aware_models =
    YAML.safe_load(ERB.new(File.read(Rails.root.join('config/tenant_aware_models.yml'))).result)

  config.tenant_column_name = :tenant_id
  # Tenant model class name
  config.class_name = 'Spree::Tenant'

  # These options are passed to the acts_as_tenant class method in the tenant_aware_classes.yml file.
  config.acts_as_tenant_args = [:tenant, { class_name: 'Spree::Tenant' }]
end

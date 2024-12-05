# frozen_string_literal: true

SolidusActAsTenant.configure do |config|
  # This configuration is used to dynamically prepend existing models with the acts_as_tenant concern.
  # See the tenant_aware_classes.yml file for inormation on how to configure this file.
  config.tenant_aware_models =
    YAML.safe_load(ERB.new(File.read(Rails.root.join('config/tenant_aware_models.yml'))).result)
end

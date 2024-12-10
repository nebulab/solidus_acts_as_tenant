class UpdateSpreeUniqueIndexesWithTenantScope < ActiveRecord::Migration[7.0]
  # If using a different tenant model, you will need to change the :::SolidusActAsTenant.config.tenant_column_name,
  # in the following indexes.
  def up
    remove_index :spree_preferences, name: :index_spree_preferences_on_key
    remove_index :spree_products, name: :index_spree_products_on_slug

    add_index :spree_preferences, [::SolidusActAsTenant.config.tenant_column_name, :key], unique: true,
      name: :index_spree_preferences_on_tenant_and_key
    add_index :spree_products, [::SolidusActAsTenant.config.tenant_column_name, :slug], unique: true,
      name: :index_spree_products_on_tenant_and_slug
  end

  def down
    remove_index :spree_preferences, name: :index_spree_preferences_on_tenant_and_key
    remove_index :spree_products, name: :index_spree_products_on_tenant_and_slug

    add_index :spree_preferences, :key, unique: true, name: :index_spree_preferences_on_key
    add_index :spree_products, :slug, unique: true, name: :index_spree_products_on_slug
  end
end

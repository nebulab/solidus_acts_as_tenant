class CreateSpreeTenants < ActiveRecord::Migration[7.0]
  def change
    create_table :spree_tenants do |t|
      t.string :name
      t.string :subdomain # Only used if setting tenant by subdomain
      t.string :domain # Only used if setting tenant by domain

      t.timestamps
    end

    add_index :spree_tenants, :name, unique: true
    add_index :spree_tenants, :subdomain, unique: true
    add_index :spree_tenants, :domain, unique: true
  end
end

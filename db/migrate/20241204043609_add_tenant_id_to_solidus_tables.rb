class AddTenantIdToSolidusTables < ActiveRecord::Migration[7.0]
  # These are tables that don't need a tenancy but may be desired:
  # spree_countries (also remove "iso" uniqueness index)
  # spree_states
  # spree_permission_sets
  # spree_roles (also remove "name" uniqueness index)
  # spree_role_permissions

  TABLES = %w[
    spree_addresses
    spree_adjustments
    spree_credit_cards
    spree_payments
    spree_refunds
    spree_roles_users
    spree_shipping_method_categories
    spree_store_credit_types
    spree_store_credits
    spree_calculators
    spree_users
    spree_adjustment_reasons
    spree_assets
    spree_cartons
    spree_customer_returns
    spree_inventory_units
    spree_line_item_actions
    spree_line_items
    spree_log_entries
    spree_option_type_prototypes
    spree_option_types
    spree_option_values
    spree_option_values_variants
    spree_orders
    spree_payment_capture_events
    spree_payment_methods
    spree_preferences
    spree_prices
    spree_product_option_types
    spree_product_properties
    spree_products
    spree_products_taxons
    spree_properties
    spree_property_prototypes
    spree_prototype_taxons
    spree_prototypes
    spree_refund_reasons
    spree_reimbursement_credits
    spree_reimbursement_types
    spree_reimbursements
    spree_return_authorizations
    spree_return_items
    spree_return_reasons
    spree_shipments
    spree_shipping_categories
    spree_shipping_method_stock_locations
    spree_shipping_method_zones
    spree_shipping_methods
    spree_shipping_rate_taxes
    spree_shipping_rates
    spree_state_changes
    spree_stock_items
    spree_stock_locations
    spree_stock_movements
    spree_store_credit_categories
    spree_store_credit_events
    spree_store_payment_methods
    spree_stores
    spree_store_shipping_methods
    spree_store_credit_reasons
    spree_tax_categories
    spree_tax_rates
    spree_taxonomies
    spree_taxons
    spree_tax_rate_tax_categories
    spree_unit_cancels
    spree_user_addresses
    spree_user_stock_locations
    spree_variant_property_rule_conditions
    spree_variant_property_rule_values
    spree_variant_property_rules
    spree_variants
    spree_wallet_payment_sources
    spree_zone_members
    spree_zones
  ].push(::Spree.user_class.table_name).uniq.freeze

  def up
    TABLES.each do |table|
      add_column table, :tenant_id, :bigint
      add_index table, :tenant_id
    end
  end

  def down
    TABLES.each do |table|
      remove_index table
      remove_column table, :tenant_id
    end
  end
end

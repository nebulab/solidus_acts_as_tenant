# frozen_string_literal: true

module SolidusActAsTenant
  module Utils
    class TenantSelector
      MESSAGES = {
        available: "Available tenants: %<tenants>s",
        prompt: "Select tenant: ",
        not_found: "Tenant not found in list '%<tenants>s'",
        current: "You are now Tenant '%<name>s'"
      }.freeze

      def ask
        return if tenants.empty?

        puts format(MESSAGES[:available], tenants: tenants) # rubocop:disable Rails/Output
        print MESSAGES[:prompt] # rubocop:disable Rails/Output

        tenant_name = ENV["DEFAULT_TENANT"] || gets.strip
        switch_tenant!(tenant_name) unless tenant_name.empty?
      end

      def tenants
        @tenants ||= fetch_tenants
      end

      def switch_tenant!(tenant_name)
        if exists?(tenant_name)
          switch(tenant_name)
        elsif numeric_tenant?(tenant_name)
          switch(tenants[tenant_name.to_i])
        else
          puts format(MESSAGES[:not_found], tenants: tenants) # rubocop:disable Rails/Output
          return false
        end

        puts format(MESSAGES[:current], name: current) # rubocop:disable Rails/Output
        true
      end

      def current
        ActsAsTenant.current_tenant&.name
      end

      private

      def fetch_tenants
        [*tenant_names].uniq
                       .each_with_index
                       .to_h { |name, index| [index, name] }
      end

      def tenant_names
        @tenant_names ||= ::SolidusActAsTenant.config.class_name.constantize.pluck(:name).sort
      end

      def switch(tenant_name)
        return false unless tenants.value?(tenant_name)

        tenant = ::SolidusActAsTenant.config.class_name.constantize.find_by(name: tenant_name)
        ActsAsTenant.current_tenant = tenant
        true
      end

      def exists?(tenant_name)
        tenant_names.include?(tenant_name)
      end

      def numeric_tenant?(tenant_name)
        tenant_name =~ /^\d+$/ && tenants.key?(tenant_name.to_i)
      end
    end
  end
end

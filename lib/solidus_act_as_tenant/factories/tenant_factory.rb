# frozen_string_literal: true

FactoryBot.define do
  factory :tenant, class: ::SolidusActAsTenant.config.class_name do
    sequence(:name) { |i| "Demo #{i}" }
    sequence(:subdomain) { |i| "demo-#{i}" }
    sequence(:domain) { |i| "demo-#{i}.com" }
  end
end

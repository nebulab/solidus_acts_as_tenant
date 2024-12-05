# frozen_string_literal: true

FactoryBot.define do
  factory :preference, class: Spree::Preference do
    sequence(:key) { |i| "Key#{i}" }
  end
end

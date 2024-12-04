# frozen_string_literal: true

Dir["#{File.dirname(__FILE__)}/../factories/**"].each do |f|
  require File.expand_path(f)
end

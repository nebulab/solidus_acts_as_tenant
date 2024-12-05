# frozen_string_literal: true

module Spree
  class ReimbursementCredit < Spree::Base
    acts_as_tenant :tenant
    belongs_to :reimbursement
    belongs_to :creditable, polymorphic: true
  end
end

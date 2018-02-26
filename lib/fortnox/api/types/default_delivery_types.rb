# frozen_string_literal: true

require 'fortnox/api/types'

module Fortnox
  module API
    module Types
      class DefaultDeliveryTypes < Types::Model
        STUB = {}.freeze

        # Default delivery type for invoices. Can be PRINT EMAIL or PRINTSERVICE.
        attribute :invoice, Types::DefaultDeliveryType

        # Default delivery type for orders. Can be PRINT EMAIL or PRINTSERVICE.
        attribute :order, Types::DefaultDeliveryType

        # Default delivery type for offers. Can be PRINT EMAIL or PRINTSERVICE.
        attribute :offer, Types::DefaultDeliveryType
      end
    end
  end
end

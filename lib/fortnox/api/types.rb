# frozen_string_literal: true

require 'dry-struct'
require 'dry-types'

module Dry
  module Types
    module Options
      def is(*option_names)
        new_options = option_names.each_with_object({}) do |name, hash|
          hash[name] = true
        end
        with(new_options)
      end

      def is?(option_name)
        @options[option_name]
      end
    end
  end
end

module Fortnox
  module API
    module Types
      include Dry::Types.module

      THE_TRUTH = { true => true, 'true' => true, false => false, 'false' => false }.freeze

      require 'fortnox/api/types/required'
      require 'fortnox/api/types/defaulted'
      require 'fortnox/api/types/nullable'

      require 'fortnox/api/types/enums'

      require 'fortnox/api/types/sized'

      AccountNumber = Strict::Int
                      .constrained(gteq: 0, lteq: 9999)
                      .optional

      ArticleType = Strict::String
                    .constrained(included_in: ArticleTypes.values)
                    .optional
                    .constructor(EnumConstructors.default)

      CountryCode = Strict::String
                    .constrained(included_in: CountryCodes.values)
                    .optional
                    .constructor(EnumConstructors.sized(2))
      Currency = Strict::String
                 .constrained(included_in: Currencies.values)
                 .optional
                 .constructor(EnumConstructors.sized(3))
      CustomerType = Strict::String
                     .constrained(included_in: CustomerTypes.values)
                     .optional
                     .constructor(EnumConstructors.default)

      DiscountType = Strict::String
                     .constrained(included_in: DiscountTypes.values)
                     .optional
                     .constructor(EnumConstructors.default)

      Email = Strict::String
              .constrained(max_size: 1024, format: /^$|\A[\w+-_.]+@[\w+-_.]+\.[a-z]+\z/i)
              .optional
              .constructor { |v| v.to_s.downcase unless v.nil? }

      HouseworkType = Strict::String
                      .constrained(included_in: HouseworkTypes.values)
                      .optional
                      .constructor(EnumConstructors.default)

      VATType = Strict::String
                .constrained(included_in: VATTypes.values)
                .optional
                .constructor(EnumConstructors.default)

      DefaultDeliveryType = Strict::String
                            .constrained(included_in: DefaultDeliveryTypeValues.values)
                            .optional
                            .constructor(EnumConstructors.default)

      ProjectStatusType = Strict::String
                          .constrained(included_in: ProjectStatusTypes.values)
                          .optional
                          .constructor(EnumConstructors.default)

      require 'fortnox/api/types/model'
      require 'fortnox/api/types/default_delivery_types'
      require 'fortnox/api/types/default_templates'
      require 'fortnox/api/types/email_information'
      require 'fortnox/api/types/edi_information'
      require 'fortnox/api/types/invoice_row'
      require 'fortnox/api/types/order_row'
    end
  end
end

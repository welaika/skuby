# frozen_string_literal: true
module Skuby
  # This class sets un the configuration.
  class Configuration
    SEND_METHODS = %w(
      send_sms_basic
      send_sms_clasic
      send_sms_classi_report
      test_send_sms_basic
      test_send_sms_clasic
      test_send_sms_classi_report
    ).freeze

    attr_accessor :username, :password, :method,
                  :sender_number, :sender_string, :charset

    def initialize
      @method = 'send_sms_classic'
    end

    def to_hash
      instance_variables.each_with_object({}) do |var, result|
        result[var.to_s.delete('@')] = instance_variable_get(var)
        result
      end
    end
  end
end

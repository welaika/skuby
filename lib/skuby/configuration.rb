module Skuby
  class Configuration
    SEND_METHODS = %w(
      send_sms_basic
      send_sms_classic
      send_sms_classic_report
      test_send_sms_basic
      test_send_sms_classic
      test_send_sms_classic_report
    ).freeze

    attr_accessor :username, :password, :method,
                  :sender_number, :sender_string, :charset

    def initialize
      @method = 'send_sms_classic'
      @charset = 'UTF-8'
    end

    def to_hash
      instance_variables.each_with_object({}) do |var, result|
        result[var.to_s.delete("@")] = instance_variable_get(var)
      end
    end
  end
end

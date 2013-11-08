module Skuby
  class Configuration

    SEND_METHODS = [
      'send_sms_basic',
      'send_sms_classic',
      'send_sms_classic_report',
      'test_send_sms_basic',
      'test_send_sms_classic',
      'test_send_sms_classic_report'
    ]

    attr_accessor :username, :password, :method,
                  :sender_number, :sender_string, :charset

    def initialize
      @method = 'send_sms_classic'
    end

    def to_hash
      instance_variables.inject({}) do |result, var|
        result[var.to_s.delete("@")] = instance_variable_get(var)
        result
      end
    end

  end
end

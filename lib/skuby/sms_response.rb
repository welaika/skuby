module Skuby
  class SmsResponse
    attr_reader :raw

    def initialize(query)
      @raw = CGI.parse(query)
    end

    def success?
      status == "success"
    end

    def failed?
      !success?
    end

    def sms_id?
      sms_id.present?
    end

    def status
      @raw["status"].first
    end

    def remaining_sms
      @raw["remaining_sms"].first.to_i
    end

    def sms_id
      @raw["id"].first
    end

    def error_code
      @raw["code"].first.to_i
    end

    def error_message
      @raw["message"].first
    end

  end
end


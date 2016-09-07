module Skuby
  class SMSResponse
    attr_reader :response, :text, :recipients

    def initialize(response, text, recipients)
      @response = CGI.parse(response)
      @text = text
      @recipients = Array(recipients)
    end

    def success?
      status == "success"
    end

    def sms_id?
      sms_id.present?
    end

    def status
      @response["status"].first
    end

    def remaining_sms
      @response["remaining_sms"].first.to_i
    end

    def sms_id
      @response["id"].first
    end

    def error_code
      @response["code"].first.to_i
    end

    def error_message
      @response["message"].first
    end
  end
end

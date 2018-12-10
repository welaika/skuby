module Skuby
  class Gateway
    include HTTParty
    base_uri 'https://gateway.skebby.it/api/send/smseasy/advanced/http.php'

    def self.send_sms(text = '', recipients = '', custom_params = nil)
      params = build_params(text, recipients, custom_params)
      SMSResponse.new(post('', body: params, verify: false), text, recipients)
    end

    def self.build_params(text, recipients, custom_params)
      if custom_params && custom_params.is_a?(Hash)
        custom_params.merge('text' => text, 'recipients[]' => recipients)
      else
        Skuby.config.to_hash.merge('text' => text, 'recipients[]' => recipients)
      end
    end
  end
end

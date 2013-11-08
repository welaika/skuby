module Skuby
  class Gateway
    include HTTParty
    base_uri 'https://gateway.skebby.it/api/send/smseasy/advanced/http.php'

    def self.send_sms(text = '', recipients = '')
      params = build_params(text, recipients)
      Response.new(post('', body: params))
    end

    def self.build_params(text, recipients)
      Skuby.config.to_hash.merge({'text' => text, 'recipients[]' => recipients})
    end
  end
end


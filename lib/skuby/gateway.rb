module Skuby
  class Gateway
    include HTTParty
    base_uri 'https://gateway.skebby.it/api/send/smseasy/advanced/http.php'

    def self.send_sms(text = '', recipients = '')
      params = build_params(text, recipients)
      SMSResponse.new(self.post('', body: params), text, recipients)
    end

    def self.build_params(text, recipients)
      recipients_hash = {}
      recipients.each_with_index do |recipient, index|
        recipient.each do |key, value|
          recipients_hash["recipients[#{index}][#{key}]"] = value
        end
      end
      recipients_hash['text'] = text
      Skuby.config.to_hash.merge(recipients_hash)
    end
  end
end

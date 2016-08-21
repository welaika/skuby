# frozen_string_literal: true
module Skuby
  # This class in the main interface with Skebby. It talks with the base_uri
  # to send an SMS.
  class Gateway
    include HTTParty
    base_uri 'https://gateway.skebby.it/api/send/smseasy/advanced/http.php'

    # Sends the SMS.
    # - text: the text of the SMS
    # - recipients: and array of hashes containing numbers and variable:
    #   [{recipient: '391234567', nome: 'Nome'}, {...}]
    def self.send_sms(text = '', recipients = '')
      params = build_params(text, recipients)
      SMSResponse.new(post('', body: params, verify: false), text, recipients)
    end

    # Builds the parameters for the http request to Skebby.
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

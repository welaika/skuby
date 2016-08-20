# frozen_string_literal: true
module Skuby
  # This class retrieves the current credit balance at Skebby.
  class Credit
    include HTTParty
    base_uri 'https://gateway.skebby.it/api/send/smseasy/advanced/http.php'

    def self.balance
      response = CGI.parse(post('', body: build_params))
      if response['status'].first == 'success'
        response['credit_left'].first.to_f
      end
    end

    def self.build_params
      Skuby.config.to_hash.merge('method' => 'get_credit')
    end
  end
end

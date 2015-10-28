module Skuby
  class Credit
    include HTTParty
    base_uri 'https://gateway.skebby.it/api/send/smseasy/advanced/http.php'

    def self.balance
      response = CGI.parse(post('', body: build_params, verify: false))
      response["credit_left"].first.to_f if response["status"].first == "success"
    end

    def self.build_params
      Skuby.config.to_hash.merge({'method' => 'get_credit'})
    end

  end
end

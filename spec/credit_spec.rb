RSpec.describe Skuby::Credit do
  before do
    Skuby.setup do |config|
      config.username = 'username'
      config.password = 'password'
      config.sender_string = 'company'
    end
  end

  context "::balance" do
    it "returns balance in euro" do
      VCR.use_cassette('get_credit') do
        request = Skuby::Credit.balance
        expect(request).to eq(9.49)
      end
    end

    context "with wrong credentials" do
      before do
        Skuby.setup { |config| config.password = 'wrong_password' }
      end

      it "returns nil if something's wrong" do
        VCR.use_cassette('get_credit_wrong_credentials') do
          expect(Skuby::Credit.balance).to be_nil
        end
      end
    end
  end
end

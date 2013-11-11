require 'spec_helper'

describe Skuby::Gateway do

  before do
    Skuby.setup do |config|
      config.username = 'username'
      config.password = 'password'
      config.sender_string = 'company'
    end
  end

  context "with send sms classic" do
    before { Skuby.setup do |config| config.method = 'send_sms_classic' end }

    it "successfully send an sms" do
      VCR.use_cassette('send_sms_classic') do
        response = Skuby::Gateway.send_sms('Lorem ipsum', '393290000000')
        expect(response.success?).to be_true
        expect(response.sms_id?).to be_false
        expect(response.remaining_sms).to eq(152)
        expect(response.text).to eq('Lorem ipsum')
        expect(response.recipients).to eq(['393290000000'])
      end
    end
  end

  context "with send sms basic" do
    before { Skuby.setup do |config| config.method = 'send_sms_basic' end }

    it "successfully send an sms" do
      VCR.use_cassette('send_sms_basic') do
        response = Skuby::Gateway.send_sms('Lorem ipsum', '393290000000')
        expect(response.success?).to be_true
        expect(response.sms_id?).to be_false
        expect(response.remaining_sms).to eq(207)
        expect(response.text).to eq('Lorem ipsum')
        expect(response.recipients).to eq(['393290000000'])
      end
    end
  end

  context "with send sms classic report" do
    before { Skuby.setup do |config| config.method = 'send_sms_classic_report' end }

    it "successfully send an sms" do
      VCR.use_cassette('send_sms_classic_report') do
        response = Skuby::Gateway.send_sms('Lorem ipsum', '393290000000')
        expect(response.success?).to be_true
        expect(response.sms_id?).to be_true
        expect(response.sms_id).to eq('64608933')
        expect(response.remaining_sms).to eq(150)
        expect(response.text).to eq('Lorem ipsum')
        expect(response.recipients).to eq(['393290000000'])
      end
    end
  end

  context "with errors in request" do
    before { Skuby.setup do |config| config.method = 'send_sms_classic_report' end }

    context "no recipient" do
      it "returns an error" do
        VCR.use_cassette('send_sms_no_recipient') do
          response = Skuby::Gateway.send_sms('Lorem ipsum')
          expect(response.success?).to be_false
          expect(response.error_code).to eq(25)
          expect(response.error_message).to be_present
          expect(response.text).to eq('Lorem ipsum')
          expect(response.recipients).to eq([""])
        end
      end
    end

    context "with wrong credentials" do
      before { Skuby.setup do |config| config.password = 'wrong_password' end }

      it "returns an error" do
        VCR.use_cassette('send_sms_wrong_credentials') do
          response = Skuby::Gateway.send_sms('Lorem ipsum', '393290000000')
          expect(response.success?).to be_false
          expect(response.error_code).to eq(21)
          expect(response.error_message).to be_present
          expect(response.text).to eq('Lorem ipsum')
          expect(response.recipients).to eq(['393290000000'])
        end
      end
    end

  end
end


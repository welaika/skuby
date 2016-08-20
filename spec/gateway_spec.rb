# frozen_string_literal: true
require 'spec_helper'

describe Skuby::Gateway do
  before do
    Skuby.setup do |config|
      config.username = 'username'
      config.password = 'password'
      config.sender_string = 'company'
    end
  end

  it 'should send sms classic' do
    Skuby.setup do |config|
      config.method = 'send_sms_classic'
    end

    VCR.use_cassette('send_sms_classic') do
      response = Skuby::Gateway.send_sms(
        'Lorem ipsum', [{ recipient: '393290000000' }]
      )
      response.success?.must_equal true
      response.sms_id?.wont_equal true
      response.remaining_sms.must_equal 152
      response.text.must_equal 'Lorem ipsum'
      response.recipients.must_equal [{ recipient: '393290000000' }]
    end
  end

  it 'should send sms basic' do
    Skuby.setup do |config|
      config.method = 'send_sms_basic'
    end

    VCR.use_cassette('send_sms_basic') do
      response = Skuby::Gateway.send_sms('Lorem ipsum',
                                         [{ recipient: '393290000000' }])
      response.success?.must_equal true
      response.sms_id?.wont_equal true
      response.remaining_sms.must_equal 207
      response.text.must_equal 'Lorem ipsum'
      response.recipients.must_equal [{ recipient: '393290000000' }]
    end
  end

  it 'should send sms classic+' do
    Skuby.setup do |config|
      config.method = 'send_sms_basic'
    end
    VCR.use_cassette('send_sms_basic') do
      response = Skuby::Gateway.send_sms('Lorem ipsum',
                                         [{ recipient: '393290000000' }])
      response.success?.must_equal true
      response.sms_id?.wont_equal true
      response.remaining_sms.must_equal 207
      response.text.must_equal 'Lorem ipsum'
      response.recipients.must_equal [{ recipient: '393290000000' }]
    end
  end

  it 'returns an error with no sender' do
    Skuby.setup do |config|
      config.method = 'send_sms_classic_report'
    end
    VCR.use_cassette('send_sms_no_recipient') do
      response = Skuby::Gateway.send_sms('Lorem ipsum', [])
      response.success?.must_equal false
      response.error_code.must_equal 25
      response.error_message.wont_be_empty
      response.text.must_equal 'Lorem ipsum'
      response.recipients.must_equal []
    end
  end

  it 'returns an error with wrong credentials' do
    Skuby.setup do |config|
      config.password = 'wrong_password'
    end
    VCR.use_cassette('send_sms_wrong_credentials') do
      response = Skuby::Gateway.send_sms('Lorem ipsum',
                                         [{ recipient: '393290000000' }])
      response.success?.must_equal false
      response.error_code.must_equal 21
      response.error_message.wont_be_empty
      response.text.must_equal 'Lorem ipsum'
      response.recipients.must_equal [{ recipient: '393290000000' }]
    end
  end
end

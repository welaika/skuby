# frozen_string_literal: true
require 'spec_helper'

describe Skuby::Credit do
  before do
    Skuby.setup do |config|
      config.username = 'username'
      config.password = 'password'
      config.sender_string = 'company'
    end
  end

  it 'returns balance in euro' do
    VCR.use_cassette('get_credit') do
      request = Skuby::Credit.balance
      request.must_equal 9.49
    end
  end

  it 'returns nil if smomething is wrong' do
    Skuby.setup do |config|
      config.password = 'wrong_password'
    end
    VCR.use_cassette('get_credit_wrong_credentials') do
      request = Skuby::Credit.balance
      request.must_be_nil
    end
  end
end

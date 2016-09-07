require 'httparty'
require 'cgi'
require 'active_support/core_ext/object'
require 'skuby/version'
require 'skuby/configuration'
require 'skuby/gateway'
require 'skuby/sms_response'
require 'skuby/report'
require 'skuby/credit'

module Skuby
  def self.setup
    yield config
  end

  def self.config
    @config ||= Configuration.new
  end
end

# Skuby

[![Build Status](https://travis-ci.org/k3rn31/skuby.svg?branch=master)](https://travis-ci.org/k3rn31/skuby)
<!--
[![Coverage Status](https://coveralls.io/repos/welaika/skuby/badge.png)](https://coveralls.io/r/welaika/skuby)
[![Code Climate](https://codeclimate.com/github/welaika/skuby.png)](https://codeclimate.com/github/welaika/skuby)
[![Dependency Status](https://gemnasium.com/welaika/skuby.png)](https://gemnasium.com/welaika/skuby) -->

NOTE: This is a fork of the original [Skuby](https://github.com/welaika/skuby) by Fabrizio Monti, Filippo Gangi Dino. This fork exists because I needed a specific behaviour from this gem. The main difference is in the recipient format.

A Ruby interface for Skebby
Allows you to send SMS through Skebby SMS Gateway.

## Installation

Add this line to your application's Gemfile:

    gem 'skuby', github: 'k3rn31/skuby', branch: 'master'

And then execute:

    $ bundle

Or install it yourself as (NOTE: this fork isn't present on rubygems.org):

    $ gem install skuby

## Usage

### Configuration

    Skuby.setup do |config|
      config.method = 'send_sms_classic' #default
      config.username = 'username'
      config.password = 'password'
      config.sender_string = 'company' #optional
      config.sender_number = '39329900000' #optional
      config.charset = 'UTF-8' #skebby default is ISO-8859-1
    end

Put these lines in `config/environments/production.rb` if you are using Skuby in Rails.

### Send SMS

Use international phone numbers without +, e.g. (for Italy) `393290000000`
NOTE: This fork of Skuby uses a hash and allows to send multiple recipients with associated variables.

    sms = Skuby::Gateway.send_sms('Lorem ipsum', [{recipient: '393290000000', nome: 'Nome'}, {...}])
    sms.success? #=> true

### Credit

To retrieve your current balance in Euros:

    Skuby::Credit.balance


## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

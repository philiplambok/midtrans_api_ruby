# frozen_string_literal: true

require 'faraday'
require 'faraday_middleware'

require 'midtrans_api/api/base'
require 'midtrans_api/api/check/status'
require 'midtrans_api/api/credit_card/charge'
require 'midtrans_api/api/credit_card/token'
require 'midtrans_api/api/gopay/charge'

require 'midtrans_api/middleware/handle_response_exception'

require 'midtrans_api/model/base'
require 'midtrans_api/model/check/status'
require 'midtrans_api/model/credit_card/charge'
require 'midtrans_api/model/credit_card/token'
require 'midtrans_api/model/gopay/charge'

module MidtransApi
  class Client
    attr_reader :config

    def initialize(options = {})
      @config = MidtransApi::Configure.new(options)

      yield @config if block_given?

      @connection = Faraday.new(url: "#{@config.api_url}/#{@config.api_version}/") do |connection|
        connection.basic_auth(@config.server_key, '')

        unless @config.notification_url.nil?
          connection.headers['X-Override-Notification'] = @config.notification_url
        end

        connection.request :json
        connection.response :json

        connection.use MidtransApi::Middleware::HandleResponseException
        connection.adapter Faraday.default_adapter
      end
    end

    def gopay_charge
      @charge ||= MidtransApi::Api::Gopay::Charge.new(self)
    end

    def credit_card_token
      @credit_card_token ||= MidtransApi::Api::CreditCard::Token.new(self)
    end

    def credit_card_charge
      @credit_card_charge ||= MidtransApi::Api::CreditCard::Charge.new(self)
    end

    def status
      @status ||= MidtransApi::Api::Check::Status.new(self)
    end

    def get(url, params)
      response = @connection.get(url, params)
      response.body
    end

    def post(url, params)
      response = @connection.post(url, params)
      response.body
    end
  end
end

require 'faraday'
require 'pingdom/check'

module Pingdom

  class Client

    attr_accessor :username, :password, :key, :conn

    def initialize
      @username= ENV['PINGDOM_USERNAME']
      @password= ENV['PINGDOM_PASSWORD']
      @key= ENV['PINGDOM_KEY']
      @conn = Faraday.new(url: 'https://api.pingdom.com' )
      @conn.basic_auth(username, password)
    end

    def has_connection?
      checks( params: { limit: 1 } )
      !Check.error?
    end

    def checks params: {}
      Check.parse get params: params, path: '/checks'
    end

    private

    def get( params: {} , path: '' )

      conn.get do |req|
        req.url "/api/#{ENV['PINGDOM_API_VERSION'] || '2.0'}#{path}"
        req.params=params
        req.headers['Content-Type'] = 'application/json'
        req.headers['App-Key'] = key
      end

    end

  end

end
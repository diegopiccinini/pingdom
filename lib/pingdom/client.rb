require 'faraday'

module Pingdom

  class Client

    attr_accessor :username, :password, :key, :conn

    def initialize u: nil , p: nil, k: nil
      @username= u || ENV['PINGDOM_USERNAME']
      @password= p || ENV['PINGDOM_PASSWORD']
      @key= k || ENV['PINGDOM_KEY']
      @conn = Faraday.new(url: 'https://api.pingdom.com' )
      @conn.basic_auth(username, password)
    end

    def has_connection?
      get( params: { limit: 1 }, path: '/checks').status == 200
    end

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

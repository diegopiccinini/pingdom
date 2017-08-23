require 'faraday'

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
      response=conn.get do |req|
        req.url '/api/2.0/checks'
        req.headers['Content-Type'] = 'application/json'
        req.headers['App-Key'] = key
      end
      response.status == 200
    end

  end

end

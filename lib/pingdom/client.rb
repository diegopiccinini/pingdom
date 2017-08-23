module Pingdom

  class Client

    attr_accessor :username, :password, :key

    def initialize
      @username= ENV['PINGDOM_USERNAME']
      @password= ENV['PINGDOM_PASSWORD']
      @key= ENV['PINGDOM_KEY']
    end

  end

end

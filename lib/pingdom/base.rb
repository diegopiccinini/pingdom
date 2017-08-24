module Pingdom
  class Base

    @@client = Client.new
    @@params= {}

    class << self

      def update_client  username: , password: , key:
        @@client = Client.new u: username, p: password, k: key
      end

      def all
        parse client.get( params: params , path: path )
      end

      def path
      end

      def parse response
        @@body= JSON.parse response.body
        @@status = response.status
      end

      def client
        @@client
      end

      def error?
        body.has_key?'error'
      end

      def body
        @@body
      end

      def status
        @@status
      end

      def params
        @@params
      end

      def params= value
        @@params=value
      end

    end

  end
end

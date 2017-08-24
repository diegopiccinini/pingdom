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
        collection.map do |data|
          self.new data
        end
      end

      def find id
        parse client.get( path: "#{path}/#{id}" )
        raise "#{id} not found" if status!=200
        self.new body[collection_type]
      end

      def path
      end

      def collection_type
        path[1..-2]
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

      def collection
        body[path[1..-1]]
      end

      def total
        body['counts']['total']
      end

      def limited
        body['counts']['limited']
      end
    end

    attr_accessor :additional_field

    def initialize data
      @additional_field={}
      data.each_pair do |k,v|
        begin
          self.send("#{k}=",v)
        rescue
          self.add k, v
        end
      end
    end

    def add key, value
      additional_field[key]=value
    end

    def get key
      begin
        self.send key
      rescue
        additional_field[key]
      end
    end

  end
end

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

      def find id, from: nil, to: nil, order: nil

        @@params={}

        @@params[:from]= from.to_i if from
        @@params[:to]= to.to_i if to
        @@params[:order]= order if order

        parse client.get( path: "#{path}/#{id}" , params: params)

        @@params={}
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
        v=Time.at(v) if is_time_attribute?(k)

        method="#{k}=".to_sym
        if self.methods.include?(method)
          self.send(method,v)
        else
          self.add(k, v)
        end
      end
    end

    def add key, value
      additional_field[key.to_sym]=value
    end

    def get key
      key=key.to_sym
      if self.methods.include?(key)
        self.send key
      else
        additional_field[key]
      end
    end

    private
    def time_attributes
      []
    end

    def is_time_attribute? key
      time_attributes.include?(key)
    end

  end
end

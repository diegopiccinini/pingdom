require 'json'

module Pingdom

  class Check

    class << self
      attr_accessor :body, :status

      def parse response
        @@body= JSON.parse response.body
        @@status = response.status
      end

      def error?
        @@body.has_key?'error'
      end

    end

  end
end

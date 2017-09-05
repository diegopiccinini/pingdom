module Pingdom

  class ServerTime < Pingdom::Base

    class << self

      def path
        '/servertime'
      end

      def get
        parse client.get( path: path )

        if body.include?('servertime')
          server_time=self.new body
        end

        server_time

      end

      def time
        get.servertime
      end


    end

    attr_accessor :servertime

    private

      def time_attributes
        %q{servertime}
      end

  end
end

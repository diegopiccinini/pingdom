require 'json'

module Pingdom

  class SumaryOutage < Pingdom::Base

    class << self

      def path
        '/summary.outage'
      end

      def collection_type
        'summary'
      end

    end

    attr_accessor :states

  end
end

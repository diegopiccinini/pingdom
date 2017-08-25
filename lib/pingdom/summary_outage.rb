require 'json'

module Pingdom

  class SummaryOutage < Pingdom::Base

    class << self

      def path
        '/summary.outage'
      end

      def collection_type
        'summary'
      end

    end

    attr_accessor :states

    def states= values

      Struct.new('State',:status, :timefrom, :timeto)

      @states=values.map do |v|
        Struct::State.new( v['status'], Time.at(v['timefrom']), Time.at(v['timeto']))
      end

    end


    def ups
      states.count { |s| s.status == 'up' }
    end

    def downs
      states.count { |s| s.status == 'down' }
    end

  end
end

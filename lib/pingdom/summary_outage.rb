module Pingdom

  Struct.new('State',:status, :timefrom, :timeto) do
    def interval
      timeto.to_i - timefrom.to_i
    end
  end

  class SummaryOutage < Pingdom::Base

    class << self

      def path
        '/summary.outage'
      end

      def collection_type
        'summary'
      end

      def permit
        {
          from: :valid_time?,
          to: :valid_time?,
          order: :valid_order?
        }
      end

    end

    attr_accessor :states

    def states= values

      @states=values.map do |v|
        Struct::State.new( v['status'], Time.at(v['timefrom']), Time.at(v['timeto']))
      end

    end


    def ups min_interval: 0
      states.count { |s| s.status == 'up' and s.interval > min_interval }
    end

    def downs min_interval: 0
      states.count { |s| s.status == 'down' and s.interval > min_interval }
    end

  end
end

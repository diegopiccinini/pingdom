module Pingdom

  Struct.new('Week',:starttime, :avgresponse, :uptime, :downtime, :unmonitored)
  Struct.new('Day',:starttime, :avgresponse, :uptime, :downtime, :unmonitored)
  Struct.new('Hour',:starttime, :avgresponse, :uptime, :downtime, :unmonitored)

  class SummaryPerformance < Pingdom::Base

    class << self

      def path
        '/summary.performance'
      end

      def collection_type
        'summary'
      end

      def permit
        {
          probes: :valid_int_list?,
          to: :valid_time?,
          from: :valid_time?,
          resolution: :valid_resolution?,
          order: :valid_order?,
          includeuptime: :valid_boolean?
        }
      end

    end

    attr_accessor :hours, :days, :weeks

    def weeks= values

      @weeks=values.map do |v|
        Struct::Week.new( Time.at(v['starttime']), v['avgresponse'], v['uptime'], v['downtime'], v['unmonitored'])
      end

    end

    def days= values

      @days=values.map do |v|
        Struct::Day.new( Time.at(v['starttime']), v['avgresponse'], v['uptime'], v['downtime'], v['unmonitored'])
      end

    end

    def hours= values

      @hours=values.map do |v|
        Struct::Hour.new( Time.at(v['starttime']), v['avgresponse'], v['uptime'], v['downtime'], v['unmonitored'])
      end

    end

  end
end

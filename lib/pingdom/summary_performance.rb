require 'json'

module Pingdom

  Struct.new('Week',:starttime, :avgresponse, :uptime, :downtime, :unmonitored)

  class SummaryPerformance < Pingdom::Base

    class << self

      def path
        '/summary.performance'
      end

      def collection_type
        'summary'
      end

    end

    attr_accessor :hours, :days, :weeks

    def weeks= values

      @weeks=values.map do |v|
        Struct::Week.new( Time.at(v['starttime']), v['avgresponse'], v['uptime'], v['downtime'], v['unmonitored'])
      end

    end

  end
end

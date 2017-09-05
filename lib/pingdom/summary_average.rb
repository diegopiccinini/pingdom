module Pingdom

  Struct.new('Avgresponse',:countryiso, :avgresponse)

  class SummaryAverage < Pingdom::Base

    class << self

      def path
        '/summary.average'
      end

      def collection_type
        'summary'
      end

      def permit
        {
          to: :valid_time?,
          from: :valid_time?,
          probes: :valid_int_list?,
          includeuptime: :valid_boolean_str?,
          bycountry: :valid_boolean_str?,
          byprobe: :valid_boolean_str?
        }
      end

    end

    attr_accessor :responsetime, :status, :avg_responses

    def avg_responses= values

      @avg_responses=values.map do |v|
        Struct::AvgResponses.new( v['countryiso'], v['avgresponse'])
      end

    end

  end
end

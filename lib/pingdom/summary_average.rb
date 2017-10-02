module Pingdom

  Struct.new('AvgResponse',:countryiso, :avgresponse)
  Struct.new('ProbeResponse',:id, :avgresponse,:from,:n, :to)
  Struct.new('AverageStatus',:totalup, :totaldown,:totalunknown)

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
          includeuptime: :valid_boolean?,
          bycountry: :valid_boolean?,
          byprobe: :valid_boolean?
        }
      end

    end

    attr_accessor :responsetime, :probe_responses

    def avgresponse
      data = responsetime['avgresponse']

      data.map! do |v|
        Struct::AvgResponse.new(v['countryiso'], v['avgresponse'])
      end  if data.is_a?(Array)
      data
    end

    def status= v
      @status=Struct::AverageStatus.new(v['totalup'],v['totaldown'],v['totalunknown'])
    end

    def status
      @status
    end


    def probe_responses
      responsetime.each_pair.map do |k,v|
        next if %q(from to).include?(k)
        Struct::ProbeResponse.new(k.to_i,v['avgresponse'],Time.at(v['from']),v['n'], Time.at(v['to']))
      end
    end

    def from
      Time.at responsetime['from']
    end

    def to
      Time.at responsetime['to']
    end

  end
end

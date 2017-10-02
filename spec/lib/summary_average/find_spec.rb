require 'spec_helper'

describe Pingdom::SummaryAverage do


  let(:id) do
    Pingdom::Check.params = { limit: 1 }
    Pingdom::Check.all.first.id
  end


  describe 'find' do

    context "whithout params" do

      let(:average) { Pingdom::SummaryAverage.find id }

      it { expect(average.avgresponse).to be_a Integer }
      it { expect(average.from).to be_a Time }
      it { expect(average.to).to be_a Time }

    end

    context "whith includeuptime" do

      let(:average) { Pingdom::SummaryAverage.find id, includeuptime: true }

      it { expect(average.avgresponse).to be_a Integer }

      it { expect(average.status.totalup).to be_a Integer }
      it { expect(average.status.totaldown).to be_a Integer }
      it { expect(average.status.totalunknown).to be_a Integer }

    end


    context "whith bycountry" do

      let(:average) { Pingdom::SummaryAverage.find id, bycountry: true }

      it { expect(average.avgresponse).to be_a Array }
      it { expect(average.avgresponse.first).to be_a Struct::AvgResponse }
      it { expect(average.avgresponse.first.countryiso.size).to eql 2 }
      it { expect(average.avgresponse.first.avgresponse).to be_a Integer }

    end

    context "whith byprobe" do

      let(:average) { Pingdom::SummaryAverage.find id, byprobe: true }
      let(:first_probe) { average.probe_responses.first }

      it { expect(average.probe_responses).to be_a Array }
      it { expect(first_probe).to be_a Struct::ProbeResponse }
      it { expect(first_probe.n).to be_a Integer }
      it { expect(first_probe.avgresponse).to be_a Integer }
      it { expect(first_probe.from).to be_a Time }
      it { expect(first_probe.to).to be_a Time }
      it { expect(first_probe.id).to be_a Integer }

    end
  end

end


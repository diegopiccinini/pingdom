require 'spec_helper'

describe Pingdom::SummaryAverage do


  let(:id) do
    Pingdom::Check.params = { limit: 1 }
    Pingdom::Check.all.first.id
  end


  describe 'find' do

    context "whithout params" do

      let(:average) { Pingdom::SummaryAverage.find id }

      it { expect(average.responsetime).to include 'avgresponse' }
      it { expect(average.responsetime).to include 'from' }
      it { expect(average.responsetime).to include 'to' }

    end
  end

end


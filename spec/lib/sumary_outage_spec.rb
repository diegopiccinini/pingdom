require 'spec_helper'

describe Pingdom::SumaryOutage do


  let(:id) do
    Pingdom::Check.params = { limit: 1 }
    Pingdom::Check.all.first.id
  end

  describe 'find' do

    let(:states) { outage.states }

    let(:outage) { Pingdom::SumaryOutage.find id }

    it { expect(states).to be_a Array }

  end
end


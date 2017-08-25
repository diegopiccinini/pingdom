require 'spec_helper'

describe Pingdom::SumaryOutage do


  let(:id) do
    Pingdom::Check.params = { limit: 1 }
    Pingdom::Check.all.first.id
  end

  let(:yesterday) { 1.days.ago.to_i }

  describe 'find' do

    let(:states) { outage.states }

    context "whithout params" do

      let(:outage) { Pingdom::SumaryOutage.find id }

      it { expect(states).to be_a Array }

    end

    context "whith param from" do

      let(:outage) { Pingdom::SumaryOutage.find id, from: yesterday }

      it "has valid times" do
        outage.states.each do |status|
          expect(status['timefrom']).to be >= yesterday
          expect(status['timeto']).to be > yesterday
        end
      end

    end

    context "whith param to" do

      let(:outage) { Pingdom::SumaryOutage.find id, from: 2.days.ago.to_i, to: yesterday }

      it "has valid times" do
        outage.states.each do |status|
          expect(status['timefrom']).to be < yesterday
          expect(status['timeto']).to be <= yesterday
        end
      end

    end
  end
end


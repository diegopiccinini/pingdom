require 'spec_helper'

describe Pingdom::SumaryOutage do


  let(:id) do
    Pingdom::Check.params = { limit: 1 }
    Pingdom::Check.all.first.id
  end

  let(:yesterday) { 1.days.ago }

  describe 'find' do

    let(:states) { outage.states }

    context "whithout params" do

      let(:outage) { Pingdom::SumaryOutage.find id }

      it { expect(states).to be_a Array }

    end

    context "whith param from" do

      let(:outage) { Pingdom::SumaryOutage.find id, from: yesterday }

      it "has valid times" do
        outage.states.each do |state|
          expect(state['timefrom']).to be >= yesterday.to_i
          expect(state['timeto']).to be > yesterday.to_i
        end
      end

    end

    context "whith param to" do

      let(:outage) { Pingdom::SumaryOutage.find id, to: yesterday }

      it "has valid times" do
        outage.states.each do |state|
          expect(state['timefrom']).to be < yesterday.to_i
          expect(state['timeto']).to be <= yesterday.to_i
        end
      end

    end

    context "whith param order asc" do

      let(:outage) { Pingdom::SumaryOutage.find id, order: 'asc' }
      let(:first_state) { outage.states.first }
      let(:last_state) { outage.states.last }

      it "has valid timefrom order" do
        expect(first_state['timefrom']).to be < last_state['timefrom']
      end

      it "has valid timeto order" do
        expect(first_state['timeto']).to be < last_state['timeto']
      end

    end

    context "whith param order desc" do

      let(:outage) { Pingdom::SumaryOutage.find id, order: 'desc' }
      let(:first_state) { outage.states.first }
      let(:last_state) { outage.states.last }

      it "has valid timefrom order" do
        expect(first_state['timefrom']).to be > last_state['timefrom']
      end

      it "has valid timeto order" do
        expect(first_state['timeto']).to be > last_state['timeto']
      end

    end

  end
end


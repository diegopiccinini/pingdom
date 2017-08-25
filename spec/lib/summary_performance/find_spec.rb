require 'spec_helper'

describe Pingdom::SummaryPerformance do


  let(:id) do
    Pingdom::Check.params = { limit: 1 }
    Pingdom::Check.all.first.id
  end

  let(:last_month) { 30.days.ago.change( hour: 0) }

  describe 'find' do

    let(:weeks) { performance.weeks }

    context "whithout params" do

      let(:performance) { Pingdom::SummaryPerformance.find id, resolution: 'week', includeuptime: 'true' }

      it { expect(weeks).to be_a Array }

    end

    context "whith param from" do

      let(:performance) { Pingdom::SummaryPerformance.find id, from: last_month, resolution: 'week', includeuptime: 'true' }

      it "has valid times" do
        performance.weeks.each do |week|
          expect(week.starttime + 1.week).to be >= last_month
        end
      end

    end

    context "whith param to" do

      let(:performance) { Pingdom::SummaryPerformance.find id, to: last_month, resolution: 'week', includeuptime: 'true' }

      it "has valid times" do
        performance.weeks.each do |week|
          expect(week.starttime).to be < last_month
        end
      end

    end

    context "whith param order asc" do

      let(:performance) { Pingdom::SummaryPerformance.find id, order: 'asc' , resolution: 'week', includeuptime: 'true'}
      let(:first_week) { performance.weeks.first }
      let(:last_week) { performance.weeks.last }

      it "has valid timefrom order" do
        expect(first_week.starttime).to be < last_week.starttime
      end

    end

    context "whith param order desc" do

      let(:performance) { Pingdom::SummaryPerformance.find id, order: 'desc' , resolution: 'week', includeuptime: 'true'}
      let(:first_week) { performance.weeks.first }
      let(:last_week) { performance.weeks.last }

      it "has valid timefrom order" do
        expect(first_week.starttime).to be > last_week.starttime
      end

    end

  end

end


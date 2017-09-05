require 'spec_helper'

describe Pingdom::SummaryPerformance do


  let(:id) do
    Pingdom::Check.params = { limit: 1 }
    Pingdom::Check.all.first.id
  end


  ['hour','day','week'].each do |resolution|

    context "#{resolution} resolution" do

      let(:resolution_method) { "#{resolution}s".to_sym }

      let(:a_period_ago) do
        if resolution== 'week'
          8.days.ago.change( hour: 0)
        else
          1.days.ago.change( hour: 0)
        end
      end

      let(:resolution_response) { performance.send(resolution_method) }

      describe 'find' do

        context "whithout params" do

          let(:performance) { Pingdom::SummaryPerformance.find id, resolution: resolution, includeuptime: 'true' }

          it { expect(resolution_response).to be_a Array }

        end

        context "whith param from" do

          let(:performance) { Pingdom::SummaryPerformance.find id, from: a_period_ago, resolution: resolution, includeuptime: 'true' }

          it "has valid times" do
            resolution_response.each do |resolution_struct|
              expect(resolution_struct.starttime + 1.send(resolution)).to be >= a_period_ago
            end
          end

        end

        context "whith param to" do

          let(:performance) { Pingdom::SummaryPerformance.find id, to: a_period_ago, resolution: resolution, includeuptime: 'true' }

          it "has valid times" do
            resolution_response.each do |resolution_struct|
              expect(resolution_struct.starttime).to be <= a_period_ago
            end
          end

        end

        context 'with order' do

          let(:first_resolution) { performance.send(resolution_method).first }
          let(:last_resolution) { performance.send(resolution_method).last }

          context "whith param order asc" do

            let(:performance) { Pingdom::SummaryPerformance.find id, order: 'asc' , resolution: resolution, includeuptime: 'true'}

            it "has valid timefrom order" do
              expect(first_resolution.starttime).to be < last_resolution.starttime
            end

          end

          context "whith param order desc" do

            let(:performance) { Pingdom::SummaryPerformance.find id, order: 'desc' , resolution: resolution, includeuptime: 'true'}

            it "has valid timefrom order" do
              expect(first_resolution.starttime).to be > last_resolution.starttime
            end

          end

        end
      end

    end
  end

end


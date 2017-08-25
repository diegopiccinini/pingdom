require 'spec_helper'

describe Pingdom::SummaryOutage do

  let(:data) do
    {
      'states' => [
        {
          "status" => "up",
          "timefrom" => 1293143523,
          "timeto" => 1294180263
        }, {
          "status" => "down",
          "timefrom" => 1294180263,
          "timeto" => 1294180323
        }, {
          "status" => "up",
          "timefrom" => 1294180323,
          "timeto" => 1294223466
        }, {
          "status" => "down",
          "timefrom" => 1294223466,
          "timeto" => 1294223523
        }, {
          "status" => "up",
          "timefrom" => 1294223523,
          "timeto" => 1294228503
        }, {
          "status" => "down",
          "timefrom" => 1294228503,
          "timeto" => 1294228563
        }, {
          "status" => "up",
          "timefrom" => 1294228563,
          "timeto" => 1294228623
        }, {
          "status" => "down",
          "timefrom" => 1294228623,
          "timeto" => 1294228743
        }, {
          "status" => "up",
          "timefrom" => 1294228743,
          "timeto" => 1294228803
        }, {
          "status" => "down",
          "timefrom" => 1294228803,
          "timeto" => 1294228987
        }, {
          "status" => "up",
          "timefrom" => 1294228987,
          "timeto" => 1294229047
        }, {
          "status" => "down",
          "timefrom" => 1294229047,
          "timeto" => 1294229583
        }, {
          "status" => "up",
          "timefrom" => 1294229583,
          "timeto" => 1294229643
        }, {
          "status" => "down",
          "timefrom" => 1294229643,
          "timeto" => 1294230063
        }, {
          "status" => "up",
          "timefrom" => 1294230063,
          "timeto" => 1294389243
        }
      ]
    }

  end

  subject { Pingdom::SummaryOutage.new data }

  let(:without_states) { Pingdom::SummaryOutage.new({ 'states' => [] }) }

  describe "#ups" do
    it { expect(subject.ups).to be == 8 }
    it { expect(without_states.ups).to be == 0 }
  end

  describe "#downs" do
    it { expect(subject.downs).to be == 7 }
    it { expect(without_states.downs).to be == 0 }
  end

end

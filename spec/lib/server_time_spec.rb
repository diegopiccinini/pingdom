require 'spec_helper'

describe Pingdom::ServerTime do

  subject { Pingdom::ServerTime.get }
  before { subject }

  it { expect(Pingdom::ServerTime.status).to eql 200 }
  it { expect(Pingdom::ServerTime.body).to include 'servertime' }
  it { expect(subject.servertime).to be_a Time }

  context 'just time' do

    it { expect(Pingdom::ServerTime.time).to be_a Time }

  end

end

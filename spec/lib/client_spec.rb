require 'spec_helper'

describe Pingdom::Client do

  describe '#initialize' do

    it "has a username" do
      expect(subject.username).to match ENV['PINGDOM_USERNAME']
    end

    it "has a password" do
      expect(subject.password).to match ENV['PINGDOM_PASSWORD']
    end

    it "has a username" do
      expect(subject.key).to match ENV['PINGDOM_KEY']
    end

  end

  describe "#has_connection?" do

    it { expect(subject.has_connection?).to be true }

  end

end


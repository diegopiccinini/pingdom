require 'spec_helper'

describe Pingdom::Check do

  let(:all) { Pingdom::Check.all }
  let(:id) do
    Pingdom::Check.params = { limit: 1 }
    all.first.id
  end

  subject { Pingdom::Check.find id }

  describe 'all' do

    let(:total) { Pingdom::Check.total }
    let(:limited) { Pingdom::Check.limited }
    let(:collection) { Pingdom::Check.collection }

    context 'without limit' do

      before do
        Pingdom::Check.all
      end

      it { expect(Pingdom::Check.params).to be == {} }
      it { expect(limited).to be total}
      it { expect(collection.count).to be total}
      it { expect(all.first).to be_a Pingdom::Check }

    end


    context 'with limit' do

      before do
        Pingdom::Check.params = { limit: 1 }
        all
      end

      it { expect(Pingdom::Check.params).to be == { limit: 1} }
      it { expect(limited).to be == 1 }
      it { expect(collection.count).to be 1 }
      it { expect(all.first).to be_a Pingdom::Check }

    end

  end


  describe 'find' do

    context 'Given a valid id' do

      it { expect(subject).to be_a Pingdom::Check }
      it { expect(subject.id).to be == id }
      it { expect(subject.name).to match subject.get('name') }
      it { expect(subject.created).to be_a Time }
      it { expect(subject.lasttesttime).to be_a Time }
      it { expect(subject.lasterrortime).to be_a Time }

    end

    context 'Given a bad id' do

      let(:id) { 11 }

      it "raise an error " do
        expect { subject }.to raise_error "#{id} not found"
      end

    end

    context 'Include tags' do

      let(:check) { Pingdom::Check.find id, include_tags: true }

      it { expect(check.tags).to be_a Array }

    end
  end

  describe '#time_attributes' do
    it { expect(subject.send :time_attributes).to include 'created' }
    it { expect(subject.send :time_attributes).to_not include 'id' }
  end

  describe '#is_time_attribute?' do
    it { expect(subject.send('is_time_attribute?','created') ).to be_truthy }
    it { expect(subject.send('is_time_attribute?','id') ).to be_falsey }
  end

end


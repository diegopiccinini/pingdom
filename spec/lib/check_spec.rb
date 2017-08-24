require 'spec_helper'

describe Pingdom::Check do

  let(:all) { Pingdom::Check.all }

  describe 'all' do

    let(:total) { Pingdom::Check.body['counts']['total'] }
    let(:limited) { Pingdom::Check.body['counts']['limited'] }
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

      let(:id) do
        Pingdom::Check.params = { limit: 1 }
        all.first.id
      end

      let(:check) { Pingdom::Check.find id }

      it { expect(check).to be_a Pingdom::Check }
      it { expect(check.id).to be == id }

    end

    context 'Given a bad id' do

      let(:id) { 11 }

      let(:check) { Pingdom::Check.find id }

      it "raise an error " do
        expect { check }.to raise_error "#{id} not found"
      end

    end
  end

end




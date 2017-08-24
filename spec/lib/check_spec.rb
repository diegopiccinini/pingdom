require 'spec_helper'

describe Pingdom::Check do

  describe 'all' do
      let(:total) { Pingdom::Check.body['counts']['total'] }
      let(:limited) { Pingdom::Check.body['counts']['limited'] }

    context 'without limit' do

      before do
        Pingdom::Check.all
      end

      it { expect(Pingdom::Check.params).to be == {} }
      it { expect(limited).to be total}

    end


    context 'with limit' do

      before do
        Pingdom::Check.params = { limit: 1 }
        Pingdom::Check.all
      end

      it { expect(Pingdom::Check.params).to be == { limit: 1} }
      it { expect(limited).to be == 1 }

    end

  end
end




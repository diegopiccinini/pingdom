require 'spec_helper'

describe Pingdom::Validator do

  let(:input) do
    {
      probes: '23,33,554,4',
      to: 5.days.ago,
      from: 10.days.ago,
      includeuptime: 'true',
      order: 'asc',
      resolution: 'week'
    }
  end

  let(:permit) do
    {
      probes: :valid_int_list?,
      to: :valid_time?,
      from: :valid_time?,
      resolution: :valid_resolution?,
      order: :valid_order?,
      includeuptime: :valid_boolean_str?
    }
  end

    let(:formated_data) do
      h=input
      h[:to] = input[:to].to_i
      h[:from] = input[:from].to_i
      h
    end

  describe '#valid_time?' do

    it { expect(subject.send(:valid_time?,Time.now)).to be true }
    it { expect(subject.send(:valid_time?,1)).to be false }
    it { expect(subject.send(:valid_time?,'2')).to be false }
    it { expect(subject.send(:valid_time?,'')).to be false }
    it { expect(subject.send(:valid_time?,'badtime')).to be false }

  end

  describe '#valid_order?' do

    it { expect(subject.send(:valid_order?,'asc')).to be true }
    it { expect(subject.send(:valid_order?,'desc')).to be true }
    it { expect(subject.send(:valid_order?,'bad')).to be false }
    it { expect(subject.send(:valid_order?,'')).to be false }


  end

  describe '#valid_resolution?' do

    it { expect(subject.send(:valid_resolution?,'hour')).to be true }
    it { expect(subject.send(:valid_resolution?,'day')).to be true }
    it { expect(subject.send(:valid_resolution?,'week')).to be true }
    it { expect(subject.send(:valid_resolution?,'bad')).to be false }

  end

  describe '#valid_boolean_str?' do

    it { expect(subject.send(:valid_boolean_str?,'true')).to be true }
    it { expect(subject.send(:valid_boolean_str?,'false')).to be true }
    it { expect(subject.send(:valid_boolean_str?,'bad')).to be false }

  end

  describe '#valid_int_list?' do

    it { expect(subject.send(:valid_int_list?, '3')).to be true }
    it { expect(subject.send(:valid_int_list?, '3,54')).to be true }
    it { expect(subject.send(:valid_int_list?, '3.4')).to be false }
    it { expect(subject.send(:valid_int_list?, '1 bad')).to be false }
    it { expect(subject.send(:valid_int_list?, '')).to be false }

  end

  describe '#filter' do

    let(:permit) { { probes: :valid_int_list? } }
    let(:input)  { { probes: '2,44,33' , another_input: 1 } }
    let(:input_filtered)  { { probes: '2,44,33' } }

    before do
      allow(subject).to receive(:permit) { permit }
      allow(subject).to receive(:input) { input }
    end

    it { expect(subject.send(:filter)).to eql input_filtered }

  end

  describe '#validate_all' do

    let(:validate_all) { subject.send(:validate_all) }

    before do
      allow(subject).to receive(:permit) { permit }
      allow(subject).to receive(:filter) { input }
    end

    context 'valid with all fields' do

      it { expect(validate_all).to eql input }

    end

    context 'valid without fields' do

      let(:input) { {} }

      it { expect(validate_all).to eql input }

    end

    context 'invalid data' do

      let(:input) { { probes: 'badintlist' }}

      it do
        expect { validate_all }.to raise_error("'probes' param with value: 'badintlist', cannot pass the 'valid_int_list?' validation")
      end

    end
  end

  describe '#format' do

    before do
      allow(subject).to receive(:permit) { permit }
      allow(subject).to receive(:input) { input }
    end

    it { expect(subject.send(:format)).to eql formated_data }

  end

  describe '#validate' do
    it { expect(subject.validate input: input, permit: permit, params: {}).to eql formated_data }
    it { expect(subject.validate input: input, permit: permit, params: { a: :a}).to eql formated_data.merge({ a: :a }) }
  end

end


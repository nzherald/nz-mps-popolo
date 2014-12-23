require 'spec_helper'

describe NZMPsPopolo::Models::Party do
  subject { NZMPsPopolo::Models::Party }

  it 'requires a name' do
    expect { subject.new(wrong_key: 'foo') }.to raise_error KeyError
  end

  describe 'from_mps' do
    let(:mp_1) { double }
    let(:mp_2) { double }
    let(:mp_3) { double }

    it 'generates parties from an array of MPs' do
      allow(mp_1).to receive(:party) { 'Apple' }
      allow(mp_2).to receive(:party) { 'Pear' }
      allow(mp_3).to receive(:party) { 'Orange' }

      result = subject.from_mps([mp_1, mp_2, mp_3])

      expect(result.map(&:class).uniq).to eq [NZMPsPopolo::Models::Party]
      expect(result[0].name).to eq 'Apple'
      expect(result[1].name).to eq 'Pear'
      expect(result[2].name).to eq 'Orange'
    end
  end
end

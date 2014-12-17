require 'spec_helper'

describe NZMPsPopolo::Parliament do
  subject { NZMPsPopolo::Parliament }

  it 'requires an ordinal number' do
    expect { subject.new(wrong_key: 'foo') }.to raise_error KeyError
  end

  it 'requires the number to be an integer' do
    expect { subject.new(number: 4.0) }.to raise_error ArgumentError
    expect { subject.new(number: '56') }.to raise_error ArgumentError
    expect { subject.new(number: 51) }.to_not raise_error
  end

  describe 'comparable' do
    let(:parliament_1) { subject.new(number: 23) }
    let(:parliament_2) { subject.new(number: 44) }
    let(:parliament_3) { subject.new(number: 51) }

    it 'compares greater than and less than' do
      expect(parliament_1 > parliament_2).to be false
      expect(parliament_3 > parliament_1).to be true
    end
  end

  describe 'ordinal inflection' do
    it 'ordinalizes properly' do
      expect(subject.new(number: 11).ordinal_number).to eq '11th'
      expect(subject.new(number: 211).ordinal_number).to eq '211th'
      expect(subject.new(number: 103).ordinal_number).to eq '103rd'
      expect(subject.new(number: 52).ordinal_number).to eq '52nd'
      expect(subject.new(number: 49).ordinal_number).to eq '49th'
      expect(subject.new(number: 1).ordinal_number).to eq '1st'
    end
  end
end

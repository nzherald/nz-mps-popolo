require 'spec_helper'

describe NZMPsPopolo::Models::MP do
  subject { NZMPsPopolo::Models::MP }

  let(:valid_attributes) do
    {
      entry_id: 'abc',
      first_names: 'Juanita',
      last_name: 'Smith',
      list: false,
      party: 'Apples and Oranges Party'
    }
  end

  %i(entry_id first_names last_name party list).each do |key|
    it "requires #{key}" do
      invalid = valid_attributes.dup
      invalid.delete(key)
      expect { subject.new(invalid) }.to raise_error KeyError
    end

  end

  it 'combines the first_names and last_name' do
    mp = subject.new(valid_attributes)
    expect(mp.name).to eq 'Juanita Smith'
  end

end

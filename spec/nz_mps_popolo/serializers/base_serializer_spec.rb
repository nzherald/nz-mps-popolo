require 'spec_helper'

describe NZMPsPopolo::Serializers::BaseSerializer do
  subject do
    foo = Class.new
    foo.send :include, NZMPsPopolo::Serializers::Popolo
    foo
  end

  it 'only accepts person, organisation, membership or post' do
    expect { subject.popolo_type :person }.to_not raise_error
    expect { subject.popolo_type :organization }.to_not raise_error
    expect { subject.popolo_type :membership }.to_not raise_error
    expect { subject.popolo_type :post }.to_not raise_error
    expect { subject.popolo_type :foo }.to raise_error ArgumentError
  end
end

require 'test_helper'

describe Jfit do
  describe "VERSION" do
    subject { Jfit::VERSION }

    it { subject.must_be_instance_of(String) }
    it { subject.must_match(/\d{1,2}\.\d{1,2}\.\d{1,2}/) }
  end
end

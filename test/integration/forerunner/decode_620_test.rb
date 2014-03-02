require 'test_helper'

describe Jfit::File do
  context "Given a forerunner 620 FIT file" do
    describe ".read" do
      subject { Jfit::File.read(io) }

      let(:device_file) { File.dirname(__FILE__) + '/../../support/device_files/forerunner/620.FIT' }
      let(:io) { ::File.open(device_file) }

      it { subject.must_be_instance_of(Jfit::File) }

      # File ID:
      #  Type: 4
      #  Manufacturer: 1
      #  Product: 1623
      #  Serial Number: 3877468399
    end
  end
end

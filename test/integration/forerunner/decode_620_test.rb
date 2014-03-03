require 'test_helper'

describe Jfit::File do
  context "Given a forerunner 620 FIT file" do
    describe ".read" do
      subject { Jfit::File.read(io) }

      let(:device_file) { File.dirname(__FILE__) + '/../../support/device_files/forerunner/620.FIT' }
      let(:io) { ::File.open(device_file) }

      it { subject.must_be_instance_of(Jfit::File) }

      it "must be a valid file" do
        subject.valid.must_equal(true)
      end

      # File ID:
      #  Type: 4
      #  Manufacturer: 1
      #  Product: 1623
      #  Serial Number: 3877468399
      context "#file_id" do
        subject { Jfit::File.read(io).file_id }

        it "must have a type of 4" do
          subject.type.must_equal(4)
        end

        it "must have a manufacturer of 1" do
          subject.manufacturer.must_equal(1)
        end

        it "must have a product of 1623" do
          subject.product.must_equal(1623)
        end

        it "must have a serial number of 3877468399" do
          subject.serial_number.must_equal(3877468399)
        end
      end
    end
  end
end

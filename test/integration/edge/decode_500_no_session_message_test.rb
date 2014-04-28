require 'test_helper'

describe Jfit::File do
  context "Given a forerunner 500 FIT file" do
    describe ".read" do
      subject { Jfit::File.read(io) }

      let(:device_file) { File.dirname(__FILE__) + '/../../support/device_files/edge/500_no_session_message.FIT' }
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

        it "must have a product of 1036" do
          subject.product.must_equal(1036)
        end

        it "must have a serial number of 3831132051" do
          subject.serial_number.must_equal(3831132051)
        end
      end

      context "session" do
        subject { Jfit::File.read(io).session }

        it "must have a total_timer_time of 1567.35205078125" do
          subject.total_timer_time.must_equal(1567.35205078125)
        end

        it "must have a total_distance of 5166.35009765625" do
          subject.total_distance.must_equal(5166.35009765625)
        end

        it "must have a total_elapsed_time of 1569.741943359375" do
          subject.total_elapsed_time.must_equal(1569.741943359375)
        end

        it "must have a timestamp of Sat Mar 01 16:33:17 EST 2014" do
          subject.timestamp.must_equal(Time.parse('2014-03-01 05:33:17 UTC'))
        end

        it "must have a start_time of Sat Mar 01 16:07:03 EST 2014" do
          subject.start_time.must_equal(Time.parse('2014-03-01 05:07:03 UTC'))
        end

        it "must have a sport of RUNNING" do
          subject.sport.must_equal('RUNNING')
        end
      end
    end
  end
end

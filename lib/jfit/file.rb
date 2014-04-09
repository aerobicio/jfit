require 'java'
require 'fit.jar'
require 'time'

module Jfit
  class File
    attr_accessor :valid, :file_id, :session

    def self.read(io)
      new.read(io)
    end

    def read(io)
      @valid = Java::ComGarminFit::Decode.check_integrity(io.to_inputstream)

      if @valid
        io.rewind

        decode = Java::ComGarminFit::Decode.new
        message_broadcaster = Java::ComGarminFit::MesgBroadcaster.new(decode)
        @file_id = FileID.new
        @session = Session.new

        message_broadcaster.add_listener(@file_id)
        message_broadcaster.add_listener(@session)
        message_broadcaster.run(io.to_inputstream)
      end

      io.close

      self
    end
  end
end

class FileID
  include Java::ComGarminFit::FileIdMesgListener

  attr_accessor :type, :manufacturer, :product, :serial_number

  java_signature 'void onMesg(Java::ComGarminFit::FileIdMesg)'
  def onMesg(message)
    if !message.get_type.nil? && message.getType != Java::ComGarminFit::File::INVALID
      @type = message.get_type.get_value
    end

    if !message.get_manufacturer.nil? && message.get_manufacturer != Java::ComGarminFit::Manufacturer::INVALID
      @manufacturer = message.get_manufacturer
    end

    if !message.get_product.nil? && message.get_product != Java::ComGarminFit::Fit::UINT16_INVALID
      @product = message.get_product
    end

    if !message.get_serial_number.nil? && message.get_serial_number != Java::ComGarminFit::Fit::UINT32Z_INVALID
      @serial_number = message.get_serial_number
    end
  end
end

class Session
  include Java::ComGarminFit::SessionMesgListener

  attr_accessor :total_timer_time, :total_distance
  attr_accessor :total_elapsed_time, :timestamp, :start_time

  java_signature 'void onMesg(Java::ComGarminFit::SessionMesg)'
  def onMesg(message)
    if !message.get_total_timer_time.nil? && message.get_total_timer_time != Java::ComGarminFit::Fit::UINT32_INVALID
      @total_timer_time = message.get_total_timer_time
    end

    if !message.get_total_distance.nil? && message.get_total_distance != Java::ComGarminFit::Fit::UINT32_INVALID
      @total_distance = message.get_total_distance
    end

    if !message.get_total_elapsed_time.nil? && message.get_total_elapsed_time != Java::ComGarminFit::Fit::UINT32_INVALID
      @total_elapsed_time = message.get_total_elapsed_time
    end

    if !message.get_timestamp.nil? && message.get_timestamp != Java::ComGarminFit::DateTime::INVALID

      @timestamp = Time.at(fit_epoch + message.get_timestamp.get_timestamp).utc
    end

    if !message.get_start_time.nil? && message.get_start_time != Java::ComGarminFit::DateTime::INVALID
      @start_time = Time.at(fit_epoch + message.get_start_time.get_timestamp).utc
    end
  end

  def fit_epoch
    @fit_epoch ||= Time.parse("1989-12-31 00:00:00 UTC").to_i
  end
end

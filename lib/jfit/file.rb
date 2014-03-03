require 'java'
require 'vendor/fit.jar'

module Jfit
  class File
    attr_accessor :valid, :file_id

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

        message_broadcaster.add_listener(@file_id)
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
    if message.get_type != nil && message.getType != Java::ComGarminFit::File::INVALID
      @type = message.get_type.get_value
    end

    if message.get_manufacturer != nil && message.get_manufacturer != Java::ComGarminFit::Manufacturer::INVALID
      @manufacturer = message.get_manufacturer
    end

    if message.get_product != nil && message.get_product != Java::ComGarminFit::Fit::UINT16_INVALID
      @product = message.get_product
    end

    if message.get_serial_number != nil && message.get_serial_number != Java::ComGarminFit::Fit::UINT32Z_INVALID
      @serial_number = message.get_serial_number
    end

  end
end

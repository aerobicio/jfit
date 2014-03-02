require 'jfit'
require 'minitest'
require 'minitest/autorun'
require 'minitest/spec'

module MiniTest
  class Spec
    class << self
      alias_method :context, :describe
    end
  end
end

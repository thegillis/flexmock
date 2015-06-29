require "minitest/autorun"
require 'flexmock/minitest'

testclass =
    if defined?(Minitest::Test) then Minitest::Test
    else MiniTest::Unit::TestCase
    end

class SimpleTest < testclass
  def test_flexmock
    flexmock()
  end
end

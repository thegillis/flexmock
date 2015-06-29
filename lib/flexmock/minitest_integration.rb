#!/usr/bin/env ruby

#---
# Copyright 2003-2013 by Jim Weirich (jim.weirich@gmail.com).
# All rights reserved.

# Permission is granted for use, copying, modification, distribution,
# and distribution of modified versions of this work as long as the
# above copyright notice is included.
#+++

begin
  require 'minitest/assertions'
rescue LoadError
  require 'minitest/unit'
end

require 'flexmock/base'
require 'flexmock/test_unit_assert_spy_called'

class FlexMock

  # Minitest::Test Integration.
  #
  # Include this module in any Test subclass (in test-style minitest) or or
  # describe block (in spec-style minitest) to get integration with FlexMock.
  # When this module is included, the mock container methods (e.g. flexmock(),
  # flexstub()) will be available.
  #
  module Minitest
    include ArgumentTypes
    include MockContainer
    include TestUnitAssertions

    # Teardown the test case, verifying any mocks that might have been
    # defined in this test case.
    def before_teardown
      super
      flexmock_teardown
    end
  end

  # Adapter for adapting FlexMock to the Test::Unit framework.
  #
  class MinitestFrameworkAdapter
    if defined?(Minitest::Test)
      include Minitest::Assertions
    else
      include MiniTest::Assertions
    end

    attr_accessor :assertions

    def initialize
      @assertions = 0
    end

    def make_assertion(msg, &block)
      unless yield
        msg = msg.call if msg.is_a?(Proc)
        assert(false, msg)
      end
    rescue assertion_failed_error => ex
      ex.message.sub!(/Expected block to return true value./,'')
      raise ex
    end

    def assertion_failed_error
      MiniTest::Assertion
    end
  end

  @framework_adapter = MinitestFrameworkAdapter.new
end


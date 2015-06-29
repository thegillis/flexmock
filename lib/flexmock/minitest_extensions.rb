#!/usr/bin/env ruby

#---
# Copyright 2003-2013 by Jim Weirich (jim.weirich@gmail.com).
# All rights reserved.

# Permission is granted for use, copying, modification, distribution,
# and distribution of modified versions of this work as long as the
# above copyright notice is included.
#+++

begin
  # Minitest 5.0+
  require 'minitest/test'
  class Minitest::Test
    include FlexMock::Minitest
  end

rescue LoadError
  # Minitest < 5.0, as shipped with ruby at least up to 2.1
  require 'minitest/unit'
  class MiniTest::Unit::TestCase
    include FlexMock::Minitest
  end
end


#!/usr/bin/env ruby

require 'test_helper'
require 'flexmock/object_extensions'

class ObjectExtensionsTest < Minitest::Test
  def setup
    @obj = Object.new
    def @obj.smethod
      :ok
    end
  end

  def test_undefined_methods_are_not_singletons
    assert ! @obj.flexmock_singleton_defined?(:xyzzy)
  end

  def test_normal_methods_are_not_singletons
    assert ! @obj.flexmock_singleton_defined?(:to_s)
  end

  def test_singleton_methods_are_singletons
    assert @obj.flexmock_singleton_defined?(:smethod)
  end
end

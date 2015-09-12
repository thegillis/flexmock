require 'test_helper'

class MockBuilderTest < Minitest::Test
  include FlexMock::Minitest

  def assert_method_name(name)
    assert_match(FlexMock::ExpectationBuilder::METHOD_NAME_RE, name)
  end

  def refute_method_name(name)
    refute_match(FlexMock::ExpectationBuilder::METHOD_NAME_RE, name)
  end

  def test_valid_method_names
    assert_method_name "foo"
    assert_method_name "FooBar"
    assert_method_name "_foo"
    assert_method_name "__foo"
    assert_method_name "___foo"
    assert_method_name "_"
    assert_method_name "foo_bar"
    assert_method_name "foo__bar"
    assert_method_name "foo_bar_"
    assert_method_name "foo12"
    assert_method_name "foo_bar_12"
    assert_method_name "foo?"
    assert_method_name "foo!"
    assert_method_name "foo="
    assert_method_name "+"
    assert_method_name "-"
    assert_method_name "*"
    assert_method_name "/"
    assert_method_name "&"
    assert_method_name "|"
    assert_method_name "^"
    assert_method_name "~"
    assert_method_name "=~"
    assert_method_name "!~"
    assert_method_name "`"
    assert_method_name "!"
    assert_method_name "**"
    assert_method_name "+@"
    assert_method_name "-@"
    assert_method_name "=="
    assert_method_name "!="
    assert_method_name "==="
    assert_method_name "<="
    assert_method_name ">="
    assert_method_name "<"
    assert_method_name ">"
    assert_method_name "<=>"
    assert_method_name "[]"
    assert_method_name "[]="
  end

  def test_invalid_method_names
    refute_method_name ""
    refute_method_name "1"
    refute_method_name "1foo"
    refute_method_name "foo!!"
    refute_method_name "foo!?"
    refute_method_name "foo?="
    refute_method_name "foo@"
    refute_method_name "++"
    refute_method_name "!!"
    refute_method_name "~="
  end
end

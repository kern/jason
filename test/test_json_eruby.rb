require 'test_helper'

class TestJSONEruby < MiniTest::Unit::TestCase
  test '= and == indicators' do
    template = <<-EOS
<%== 'blah' %>
<%= 'blah' %>
EOS
    eruby = Jason::JSONEruby.new(template)
    assert_equal "blah\n\"blah\"\n", eruby.result
  end
end
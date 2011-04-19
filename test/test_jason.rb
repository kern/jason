require 'test_helper'

class TestJason < MiniTest::Unit::TestCase
  def test_render_without_binding
    template = <<-EOF
      foo: bar
      baz:
        - quz
        - quuz
    EOF
    
    assert_equal({'foo' => 'bar', 'baz' => ['quz', 'quuz']}, JSON.parse(Jason.render(template)))
  end
  
  def test_render_with_binding
    test_string = 'bar'
    template = <<-EOF
      foo: <%= test_string %>
    EOF
    
    assert_equal({'foo' => 'bar' }, JSON.parse(Jason.render(template, binding)))
  end
  
  def test_compile
    test_string = 'bar'
    template = <<-EOF
      foo: <%= test_string %>
    EOF
    
    assert_equal({'foo' => 'bar' }, JSON.parse(eval(Jason.compile(template))))
  end
end
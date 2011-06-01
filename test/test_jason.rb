require 'test_helper'

class TestJason < MiniTest::Unit::TestCase
  test '.render without binding' do
    template = <<-EOF
      {
        "foo": "bar",
        "baz": [
          <% if true %>
            "quz",
          <% end %>
          "quuz",
        ]
      }
    EOF
    
    assert_equal({ 'foo' => 'bar', 'baz' => ['quz', 'quuz'] }, JSON.load(Jason.render(template)))
  end
  
  test '.render with binding' do
    test_string = 'bar'
    template = <<-EOF
      { "foo": <%= test_string %>, }
    EOF
    
    assert_equal({ 'foo' => 'bar' }, JSON.load(Jason.render(template, binding)))
  end
  
  test '.compile' do
    test_string = 'bar'
    template = <<-EOF
      { "foo": "<%== test_string %>", }
    EOF
    
    assert_equal({ 'foo' => 'bar' }, JSON.load(eval(Jason.compile(template))))
  end
  
  test '.process' do
    template = <<-EOF
      {
        "foo": "bar",
        "baz": [
          "quz",
          "quuz",
        ],
      }
    EOF
    
    assert_equal({ 'foo' => 'bar', 'baz' => ['quz', 'quuz'] }, JSON.load(Jason.process(template)))
  end
end
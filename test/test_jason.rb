require 'test_helper'

class TestJason < MiniTest::Unit::TestCase
  test '.render without binding' do
    template = <<-EOF
{
  "message": "OK",
  "user": {
    "id": <%= 'test' %>,
    "name": <%= 'blah' %>,
    <% if true %>
      "link": [
        <% if true %>
          {
            "rel": "self",
            "href": <%= 'hablaba' %>
          },
        <% end %>
        {
          "rel": "checkins",
          "href": <%= 'hablaba' %>
        }
      ]
    <% end %>
  }
}
EOF
    
    assert_equal({
      'message' => 'OK',
      'user' => {
        'id' => 'test',
        'name' => 'blah',
        'link' => [
          {
            'rel' => 'self',
            'href' => 'hablaba'
          },
          {
            'rel' => 'checkins',
            'href' => 'hablaba'
          }
        ]
      }
    }, JSON.load(Jason.render(template)))
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
  
  test '.output_format' do
    assert_equal :compact, Jason.output_format
    assert_equal '{"foo":["bar"]}', Jason.process('{"foo":["bar"]}')
    
    Jason.output_format = :pretty
    assert_equal :pretty, Jason.output_format
    assert_equal "{\n  \"foo\": [\n    \"bar\"\n  ]\n}", Jason.process('{"foo":["bar"]}')
  end
  
  test '.output_listeners' do
    assert_equal [], Jason.output_listeners
    
    listener = mock
    listener.expects(:call).with({"foo" => ["bar"]})
    Jason.output_listeners << listener
    
    Jason.process('{"foo":["bar"]}')
  end
  
  def teardown
    Jason.output_format = :compact
    Jason.output_listeners = []
  end
end

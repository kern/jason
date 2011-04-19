require 'test_helper'

class JasonTest < ActionDispatch::IntegrationTest
  def test_render_json
    get '/', :format => :json
    assert_equal({ 'instance' => 'OK', 'local' => 'OK' }, JSON.parse(response.body))
  end
end
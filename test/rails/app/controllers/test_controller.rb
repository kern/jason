class TestController < ApplicationController
  def index
    @instance_var = 'OK'
    render 'index', :locals => { :local_var => 'OK' }
  end
end
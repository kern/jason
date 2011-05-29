ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

MiniTest::Unit.runner = Journo::SuiteRunner.new
MiniTest::Unit.runner.reporters << Journo::Reporters::ProgressReporter.new
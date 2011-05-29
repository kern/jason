require 'bundler/setup'
require 'minitest/autorun'
require 'mocha'
require 'jason'
require 'journo'
require 'test_declarative'

Dir[File.dirname(__FILE__) + '/support/**/*.rb'].each { |f| require f }

MiniTest::Unit.runner = Journo::SuiteRunner.new
MiniTest::Unit.runner.reporters << Journo::Reporters::ProgressReporter.new
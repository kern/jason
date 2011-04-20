require 'bundler'
Bundler::GemHelper.install_tasks

task :default => 'test:unit'

task :test => ['test:unit', 'test:rails']

require 'rake/testtask'
Rake::TestTask.new('test:unit') do |t|
  t.ruby_opts += ['-rubygems']
  t.libs << 'test'
  t.pattern = 'test/test_*.rb'
end

task 'test:rails' do
  sh <<-CMD
    cd test/rails
    rake
  CMD
end
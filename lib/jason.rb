require 'erb'
require 'json'
require 'yaml'

module Jason
  # Render a template.
  # 
  # @example
  #     Jason.render('foo: bar') # => '{"foo": "bar"}'
  # 
  # @param template [String] the template to render
  # @param binding [Binding] the binding to render the template in
  # @return [String] the rendered template
  def self.render(template, binding = nil)
    yaml = ERB.new(template).result(binding)
    YAML::load(yaml).to_json
  end
  
  # Compile a template.
  # 
  # Eval the returned value to render the template within the current binding.
  # 
  # @param template [String] the template to compile
  # @return [String] the compiled template
  def self.compile(template)
    "#{ERB.new(template).src}; YAML::load(_erbout).to_json"
  end
end

require 'jason/version'

if defined? ActionView::Template
  require 'jason/rails_template_handler'
end
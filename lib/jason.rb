require 'ember'
require 'json'
require 'yaml'

# Renders and compiles Jason templates.
module Jason
  # Render a template.
  # 
  # @example
  #     Jason.render('foo: bar') # => '{"foo": "bar"}'
  # 
  # @param [String] template the template to render
  # @param [Binding] binding the binding to render the template in
  # @return [String] the rendered template
  def self.render(template, binding = nil)
    if binding
      yaml = ember_template(template).render(binding)
    else
      yaml = ember_template(template).render
    end
    
    YAML::load(yaml).to_json
  end
  
  # Compile a template.
  # 
  # Eval the returned value to render the template within the current binding.
  # 
  # @param [String] template the template to compile
  # @return [String] the compiled template
  def self.compile(template)
    "YAML::load(#{ember_template(template).program}).to_json"
  end
  
  private
  
  def self.ember_template(template)
    Ember::Template.new(template,
      :unindent => true,
      :infer_end => true,:shorthand => true
    )
  end
end

require 'jason/version'

if defined? ActionView::Template
  require 'jason/rails_template_handler'
end
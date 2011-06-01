require 'erubis'
require 'json'
require 'strscan'

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
      yaml = eruby_template(template).result(binding)
    else
      yaml = eruby_template(template).result
    end
    
    process(yaml)
  end
  
  # Compile a template.
  # 
  # Eval the returned value to render the template within the current binding.
  # 
  # @param [String] template the template to compile
  # @return [String] the compiled template
  def self.compile(template)
    "#{eruby_template(template).src}; Jason.process(_buf)"
  end
  
  # Process a rendered buffer.
  # 
  # Removes any trailing commas and compresses the buffer.
  # 
  # Usually, you should not have to call this method.
  # 
  # @param [String] buffer
  def self.process(buffer)
    JSON.load(remove_trailing_commas(buffer)).to_json
  end
  
  private
  
  def self.eruby_template(template)
    JSONEruby.new(template)
  end
  
  # Based upon the string scanner found in jnunemaker's crack.
  # 
  # @see https://github.com/jnunemaker/crack crack
  def self.remove_trailing_commas(json)
    comma_position = nil
    quoting = nil
    scanner = StringScanner.new(json)
    
    while scanner.scan_until(/(\\['"]|['",\]\}])/)
      case char = scanner[1]
      when '"', "'"
        if !quoting
          quoting = char
        elsif quoting == char
          quoting = nil
        end
      when ']', '}'
        if comma_position && json[comma_position + 1...scanner.pos - 1] =~ /^\s*$/
          json[comma_position] = ''
          scanner.pos -= 1
          comma_position = nil
        end
      when ','
        comma_position = scanner.pos - 1 unless quoting
      end
    end
    
    json
  end
end

require 'jason/version'
require 'jason/json_eruby'

if defined? ActionView::Template
  require 'jason/rails_template_handler'
end
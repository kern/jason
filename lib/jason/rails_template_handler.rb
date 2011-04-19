module Jason
  # Rails plugin for using Jason as a template handler.
  # 
  # Name your view templates like so: `view_name.jason`.
  # 
  # Jason loads this module only if it can find `ActionView`.
  class RailsTemplateHandler
    class_attribute :default_format
    self.default_format = Mime::JSON
    
    # Compile the Rails template.
    # 
    # @param template [Class] the Rails template class
    # @return [String] the compiled template
    def call(template)
      Jason.compile(template.source)
    end
  end
end

ActionView::Template.register_template_handler(:jason, Jason::RailsTemplateHandler.new)
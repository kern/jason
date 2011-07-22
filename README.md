# jason - insanely simple JSON templates [![StillMaintained Status](http://stillmaintained.com/CapnKernul/jason.png)](http://stillmaintained.com/CapnKernul/jason) [![Build Status](http://travis-ci.org/CapnKernul/jason.png)](http://travis-ci.org/CapnKernul/jason) #

## Problem ##

There's no easy way to create JSON templates in Ruby.

## Solution ##

Use Erubis to make the simplest thing that could possibly work.

## Installation ##

    gem install jason

## Usage ##

You write jason templates in a fashion similar to regular old JSON with a
notable exception: trailing commas in arrays and objects are automatically
removed. This allows you to easily create JSON templates using iterators.

    Jason.render('{ "foo": "bar" }') # => '{"foo":"bar"}'
    
    Jason.render(<<-EOS
    {
      "test": [
        <% if true %>
          "foo",
        <% end %>
        "bar", <%# Notice how this trailing comma is perfectly valid. %>
      ]
    }
    EOS
    ) # => '{"test":["foo","bar"]}'

Jason also redefines the `<%= expr %>` Erubis delimiter so that it converts the
expression to a JSON value by calling `#to_json` on the expression. If you'd
like to use regular interpolation, use the `<%== expr %>` delimiter instead.

    Jason.render('<%= 'test' %>') # => '"test"'
    Jason.render('"<%== 'test' %>"') # => '"test"'

You can configure the output format of the JSON:

    Jason.output_format = :compact # This is the default.
    Jason.output_format = :pretty

`:compact` will remove any unnecessary whitespace in the JSON while `:pretty`
will indent the result JSON so that it looks, well, pretty.

You can add output listeners to jason so that you can run arbitrary code upon
the generated JSON. For example, if you'd like to log all of the JSON responses
in Rails:

    Jason.output_listeners << lambda do |hash|
      Rails.logger.info("[Jason] Generated output:\n#{JSON.pretty_generate(hash)}")
    end
    

## Usage with Rails ##

Name your view template with the extension `jason`. Everything else is the same.

    # in view_name.jason
    {
      "foo": "bar",
      "baz": [
        <% unless @we_started_the_fire %>
          "quz",
          "quuz",
        <% end %>
      ]
    }
    
    # Renders: {"foo":"bar","baz":["quz","quuz"]}

## Note on Patches/Pull Requests ##

* Fork the project.
* Make your feature addition or bug fix.
* Add tests for it. This is important so I don't break it in a future version unintentionally.
* Commit, but do not mess with the `Rakefile`. If you want to have your own version, that is fine but bump the version in a commit by itself in another branch so I can ignore it when I pull.
* Send me a pull request. Bonus points for git flow feature branches.

## Resources ##

* [GitHub Repository](https://github.com/CapnKernul/jason)
* [Documentation](http://rubydoc.info/github/CapnKernul/jason)

## License ##

Jason is licensed under the MIT License. See `LICENSE` for details.

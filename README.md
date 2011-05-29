# jason - insanely simple JSON templates [![StillMaintained Status](http://stillmaintained.com/CapnKernul/jason.png)](http://stillmaintained.com/CapnKernul/jason) [![Build Status](http://travis-ci.org/CapnKernul/jason.png)](http://travis-ci.org/CapnKernul/jason) #

## Problem ##

There's no easy way to create JSON templates in Ruby.

## Solution ##

Use YAML and Ember to make the simplest thing that could possibly work.

## Installation ##

    gem install jason

## Usage ##

You write jason templates in plain YAML and Ember. Jason will take care of the
(ultra-simple) conversion to JSON. You can use the Ember shorthand syntax, leave
off the `end` of blocks, and use natural indentation, since Ember will
automatically unindent blocks for you.

    Jason.render('foo: bar') # => '{"foo":"bar"}'
    
    Jason.render(<<-EOS
    test:
      % if true
        - foo
      - bar
    EOS
    ) # => '{"test":["foo","bar"]}'

That's it.

## Usage with Rails ##

Name your view template with the extension `jason`. Everything else is the same.

    # in view_name.jason
    foo: bar
    baz:
      % unless @we_started_the_fire
        - quz
        - quuz
    
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
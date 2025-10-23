# frozen_string_literal: true

require_relative 'lib/blankity/version'

Gem::Specification.new do |spec|
  spec.name    = 'blankity'
  spec.version = Blankity::VERSION
  spec.author  = 'Sam Westerman'
  spec.email   = 'mail@sampersand.me'

  spec.summary = 'Provides "blank" objects which *only* supply conversion methods'
  spec.description = <<~EOS
    There's a lot of conversion methods in Ruby: to_s, to_a, to_i, etc. This gem provides types
    which *only* respond to these conversion methods, and nothing else.
  EOS

  spec.homepage = 'https://github.com/sampersand/blankity'
  spec.license  = 'MIT'
  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata['homepage_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) || f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile])
    end
  end
end

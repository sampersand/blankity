# Blankity

Blankity is a gem that provides "blank objects," which define minimal methods.

## Installation

Install the gem and add to the application's Gemfile by executing:
```bash
bundle add blankity
```

If bundler is not being used to manage dependencies, install the gem by executing:
```bash
gem install blankity
```

## Usage

The `Blankity::Blank` class `undef`s all methods (other than `__send__` and `__id__`) from `BasicObject`:
```ruby
# No methods are defined
blank = Blankity::Blank.new
p defined?(blank.==)      #=> nil
p defined?(blank.inspect) #=> nil

# Include specific `Object` methods:
blank = Blankity::Blank.new(methods: [:==])
p blank == blank #=> true

# Also supports blocks, which are `instance_exec`ed
p Blankity::Blank.new { def inspect = "hi" } #=> "hi"
```

Also supplied are `Blankity::ToXXX` classes, which just define the conversion methods that are used throughout Ruby's stdlib:
```ruby
# String#* calls `.to_int` on its argument:
p 'a' * Blankity::ToInt.new(3) #=> "aaa"

# File.exist? calls `.to_path` on its argument:
p File.exist? Blankity::ToPath.new('/tmp/foo') #=> false

# Array#[] accepts custom ranges:
p %w[a b c d][Blankity::Range.new(1, 3)] #=> ["b", "c", "d"]

```

As a convenience, `Blankity::To` defines these conversion methods:
```ruby
puts 'hello' + Blankity::To.str(' world')
#=> hello world

puts 'hello'.gsub(/[eo]/, Blankity::To.hash('e' => 'E', 'o' => 'O'))
#=> hEllO
```

The `Blankity::To` module is also a mixin!
```ruby
extend Blankity::To

puts 'hello' + str(' world')
exit int(0)

# Let's get crazy!
system(
  hash(
    str('HELLO', hash: true) => str('WORLD')
  ),
  ary(str('sh'), str('-sh')),
  str('-c'),
  str('echo $0 $HELLO $PWD'),
  chdir: path('/'),
)
```

## Development

Run tests via `rake test` and `steep check`.

Before pushing new versions, make sure to run `bundle exec rbs-inline --output lib` to generate new rbs signatures, and to update the `version.rb` file.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sampersand/blankity.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

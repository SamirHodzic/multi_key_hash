# MultiKeyHash

Hash with multiple keys for same value, symbol/string-indifferent key access.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'multi_key_hash'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install multi_key_hash

## Usage

#### Creating new multiple keys hash and accessing it's keys

```ruby
require 'multi_key_hash'

multi_hash = MultiKeyHash.new({%w[one two three] => 'number', %i[a b c] => 'letter', 'single' => 'value'})

multi_hash['one']         # number
multi_hash[:a]            # letter
multi_hash['single']      # value
```

#### Modifying values inside hash

```ruby
multi_hash = MultiKeyHash.new({%w[one two three] => 'number', %i[a b c] => 'letter', 'single' => 'value'})

multi_hash['one'] = 'first_number'         # first_number
multi_hash['two']                          # number

multi_hash[:a] = 'first_letter'            # first_letter
multi_hash[:b]                             # letter
```

#### Adding new keys to hash

```ruby
multi_hash = MultiKeyHash.new({%w[one two three] => 'number', %i[a b c] => 'letter', 'single' => 'value'})

multi_hash[:language] = 'english'                         # single key
multi_hash[[:ruby, :js, :php]] = 'programming_language'   # multiple keys
```

#### Deleting keys from hash

```ruby
multi_hash = MultiKeyHash.new({%w[one two three] => 'number', %i[a b c] => 'letter', 'single' => 'value'})

multi_hash.delete(:a)
multi_hash[:b]             #letter

multi_hash.delete('one')
multi_hash['two']          #number
```

#### Converting to regular hash

```ruby
multi_hash = MultiKeyHash.new({%w[one two three] => 'number', %i[a b c] => 'letter', 'single' => 'value'})

multi_hash.to_h

# {
#   'one'    => 'number',
#   'two'    => 'number',
#   'three'  => 'number',
#   :a       => 'letter',
#   :b       => 'letter',
#   :c       => 'letter',
#   'single' => 'value'
# }
```

## License

[MIT License](https://opensource.org/licenses/MIT).

# nested_send
An extension for Ruby's `Object` object to allow for nested send functionality using a naturally formatted string.

This makes it possible to access deep attributes using `send` without having to establish your own set of recursion and attribute checking.

Currently, there is no support for method arguments. You will not be able to use: `@object.nested_send("join('')")` for example. This will be coming at a slightly later date when I have the time to update it. 

However, you can chain for as long as you like otherwise: `@object.nested_send("to_sym.to_s.to_sym.to_s")` and such.

### Installation
##### Gemfile:  
`gem 'nested_send'`  

##### Local:
`gem install nested_send`

### Usage:  
`require 'nested_send'`

### Examples
```ruby
require 'nested_send'

class TestingObject
  attr_accessor :name, :books, :traits, :preferences

  def initialize(args = {})
    @name = args[:name] ||= "Will"
    @books = args[:books] ||= ["Moby Dick", "The Two Towers", "Hank the Cowdog"]
    @traits = args[:traits] ||= { height: 180, weight: 175, age: 30}
    @preferences = args[:preferences] ||= { "email" => true }
  end

  def itself
    self
  end

end

# Methods
@object = TestingObject.new
@object.nested_send("name.to_sym")
# => :Will

# Arrays
@object.nested_send("books[0]")
# => "Moby Dick"

# Works with symbolized hash keys
@object.nested_send("traits[:age]")
# => 30

# Works with stringified hash keys
@object.nested_send("preferences['email']")
# => true
```

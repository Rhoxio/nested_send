# nested_send
A gem for Ruby that extends Ruby's `Object` to allow for send functionality using formatted strings to execute chained sends.

This makes it possible to access deep attributes using `send` without having to establish your own set of recursion and attribute checking.

Currently, there is no support for method arguments. You will not be able to use: `[1,2,3].join('')` for example. 

However, you can chain for as long as you like otherwise: `"Dog".to_sym.to_s.to_sym.to_s` and such.

### Examples
```ruby
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

# Works with strigified hash keys
@object.nested_send("preferences['email']")
# => true
```

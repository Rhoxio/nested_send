# nested_send
A gem for Ruby that extends `Object` to allow for send functionality using formatted strings to execute chained sends.

This makes it possible to access deep attributes using `send` without having to establish your own set or recursion and attribute checking.

### Examples
```
class TestingObject
  attr_accessor :name, :books, :traits, :preferences

  def initialize(args = {})
    @name = args[:name] ||= "Will"
    @books = args[:books] ||= ["Moby Dick", "The Two Towers", "Hank the Cowdog"]
    @traits = args[:traits] ||= { height: 180, weight: 175, age: 30}
    @preferences = args[:preferences] ||= { "email" => true}
  end

  def itself
    self
  end

end

@object = TestingObject.new
@object.nested_send("name.to_sym")
# => :Will

@object.nested_send("books[0]")
# => "Moby Dick"

@object.nested_send("traits[:age]")
# => 30
```

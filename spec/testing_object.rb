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
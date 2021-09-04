require_relative 'testing_object'
require_relative '../lib/nested_send'

describe Object do 

  before(:each) do
    @object = TestingObject.new
  end

  describe "object attribute access" do 
    it "will allow access to object attributes" do 
      expect(@object.nested_send("name")).to eq("Will")
    end

    it "will allow chained access on object attributes" do 
      expect(@object.nested_send("name.to_sym")).to eq(:Will)
    end

    it "will allow for combinatory chains" do
      expect(@object.nested_send("books.join")).to eq("Moby DickThe Two TowersHank the Cowdog")
    end
  end

  describe "object method access" do 
    it "will allow for self contexts to be called" do 
      expect(@object.nested_send("itself")).to eq(@object)
    end

    it "will allow for object methods to be called" do 
      expect(@object.nested_send("methods[0]")).to eq(@object.methods[0])
    end

    it "will allow for chained object methods to be called" do 
      expect(@object.nested_send("methods[0].to_s")).to eq(@object.methods[0].to_s)
    end
  end

  describe "array access" do
    it "will access an array that is nested" do 
      expect(@object.nested_send("books[0]")).to eq("Moby Dick")
    end
  end

  describe "hash access" do 
    it "will access hash that is nested" do 
      expect(@object.nested_send("traits[:age]")).to eq(30)
    end

    it "will access hash with symbol notation" do 
      expect(@object.nested_send("traits[:weight]")).to eq(175)
    end

    it "will access hash with string key notation" do 
      expect(@object.nested_send("preferences['email']")).to eq(true)
    end
  end

  describe "error cases" do 
    it "will error out if a bad string is supplied" do 
      expect{@object.nested_send("preferences[:anything]/monkey")}.to raise_error(ArgumentError)
    end
    
  end

end
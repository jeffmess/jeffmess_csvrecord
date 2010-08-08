require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "CsvRecord" do
  
  it "should be able to read csv files in other directories" do
    pending
  end
  
  it "should raise an error if the file is not a csv file" do
    pending
    CsvRecord.make('products.cv').should raise_error(RuntimeError)
  end
  
  it "should be able to create a class determined by the name of the file" do
    CsvRecord.make('author.csv')
    Author.is_a?(Class).should == true
  end
  
  it "should create an array of objects when the read method on the class is called" do
    CsvRecord.make('author.csv')
    records = Author.read
    records.is_a?(Array).should == true
  end
  
  it "should remove escaping quotes when creating the objects for a csv file" do
    CsvRecord.make('author.csv')
    records = Author.read
    records.each do |record|
      record.firstname.include?("\\\"").should == false
    end
  end
  
end
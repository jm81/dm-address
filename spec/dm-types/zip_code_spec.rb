require 'spec_helper'

describe DataMapper::Types::ZipCode do

  before(:each) do
    @klass = DataMapper::Types::ZipCode
    @zip_str  = "12345-6789"
    @zip_dump = "123456789"
    @zip = DataMapper::Address::ZipCode.new(@zip_str)
  end
 
  describe ".dump" do
    it "should return the Zip Number as a digits-only string" do
      @klass.dump(@zip, :property).should == @zip_dump
    end
 
    it "should return nil if the string is nil" do
      @klass.dump(nil, :property).should be_nil
    end
 
    it "should return an empty String if the Zip Number is empty" do
      @klass.dump(DataMapper::Address::ZipCode.new(''), :property).should == ""
    end
  end
 
  describe ".load" do
    it "should return the string as ZipCode" do
      @klass.load(@zip_str, :property).should == @zip
    end
 
    it "should return nil if given nil" do
      @klass.load(nil, :property).should be_nil
    end
 
    it "should return an empty Zip Code if given an empty string" do
      @klass.load("", :property).should == DataMapper::Address::ZipCode.new('')
    end
 
    it 'should raise an ArgumentError if given something else' do
      lambda {
        @klass.load([], :property)
      }.should raise_error(ArgumentError, '+value+ must be nil or a String')
    end
  end
 
  describe '.typecast' do
    it 'should do nothing if an ZipCode is provided' do
      @klass.typecast(@zip, :property).should == @zip
    end
 
    it 'should defer to .load if a string is provided' do
      @klass.should_receive(:load).with(@zip_str, :property)
      @klass.typecast(@zip_str, :property)
    end
  end
end

require 'spec_helper'

describe DataMapper::Types::PhoneNumber do

  before(:each) do
    @klass = DataMapper::Types::PhoneNumber
    @phone_str  = "(405) 555-1234"
    @phone_dump = "4055551234"
    @phone = DataMapper::Address::PhoneNumber.new(@phone_str)
  end
 
  describe ".dump" do
    it "should return the Phone Number as a digits-only string" do
      @klass.dump(@phone, :property).should == @phone_dump
    end
 
    it "should return nil if the string is nil" do
      @klass.dump(nil, :property).should be_nil
    end
 
    it "should return an empty String if the Phone Number is empty" do
      @klass.dump(DataMapper::Address::PhoneNumber.new(''), :property).should == ""
    end
  end
 
  describe ".load" do
    it "should return the string as PhoneNumber" do
      @klass.load(@phone_str, :property).should == @phone
    end
 
    it "should return nil if given nil" do
      @klass.load(nil, :property).should be_nil
    end
 
    it "should return an empty Phone Number if given an empty string" do
      @klass.load("", :property).should == DataMapper::Address::PhoneNumber.new('')
    end
 
    it 'should raise an ArgumentError if given something else' do
      lambda {
        @klass.load([], :property)
      }.should raise_error(ArgumentError, '+value+ must be nil or a String')
    end
  end
 
  describe '.typecast' do
    it 'should do nothing if an PhoneNumber is provided' do
      @klass.typecast(@phone, :property).should == @phone
    end
 
    it 'should defer to .load if a string is provided' do
      @klass.should_receive(:load).with(@phone_str, :property)
      @klass.typecast(@phone_str, :property)
    end
  end
end

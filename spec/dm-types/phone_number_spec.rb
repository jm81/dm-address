require 'spec_helper'
require 'fixtures/types-fixture'

describe DataMapper::Property::PhoneNumber do
  subject { TypesFixture.properties[:phone] }
  
  before(:each) do
    @phone_str  = "(405) 555-1234"
    @phone_dump = "4055551234"
    @phone = DataMapper::Address::PhoneNumber.new(@phone_str)
  end
 
  describe ".dump" do
    it "should return the Phone Number as a digits-only string" do
      subject.dump(@phone).should == @phone_dump
    end
 
    it "should return nil if the string is nil" do
      subject.dump(nil).should be_nil
    end
 
    it "should return an empty String if the Phone Number is empty" do
      subject.dump(DataMapper::Address::PhoneNumber.new('')).should == ""
    end
  end
 
  describe ".load" do
    it "should return the string as PhoneNumber" do
      subject.load(@phone_str).should == @phone
    end
 
    it "should return nil if given nil" do
      subject.load(nil).should be_nil
    end
 
    it "should return an empty Phone Number if given an empty string" do
      subject.load('').should == DataMapper::Address::PhoneNumber.new('')
    end
 
    it 'should return nil if given something else' do
      subject.load([]).should be(nil)
    end
  end
end

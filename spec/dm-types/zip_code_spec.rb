require 'spec_helper'
require 'fixtures/types-fixture'

describe DataMapper::Property::ZipCode do
  subject { TypesFixture.properties[:zip] }

  before(:each) do
    @zip_str  = "12345-6789"
    @zip_dump = "123456789"
    @zip = DataMapper::Address::ZipCode.new(@zip_str)
  end

  describe ".dump" do
    it "should return the Zip Number as a digits-only string" do
      subject.dump(@zip).should == @zip_dump
    end

    it "should return nil if the string is nil" do
      subject.dump(nil).should be_nil
    end

    it "should return an empty String if the Zip Number is empty" do
      subject.dump(DataMapper::Address::ZipCode.new('')).should == ""
    end
  end

  describe ".load" do
    it "should return the string as ZipCode" do
      subject.load(@zip_str).should == @zip
    end

    it "should return nil if given nil" do
      subject.load(nil).should be_nil
    end

    it "should return an empty Zip Code if given an empty string" do
      subject.load("").should == DataMapper::Address::ZipCode.new('')
    end

    it 'should return nil if given something else' do
      subject.load([]).should be(nil)
    end
  end
end

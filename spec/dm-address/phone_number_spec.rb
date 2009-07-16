require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe DataMapper::Address::PhoneNumber do
  before(:all) do
    @klass = DataMapper::Address::PhoneNumber
  end
  
  describe '.new' do
    it 'should strip out non-digits' do
      @klass.new('405-555-5555').should == '4055555555'
      @klass.new('(405) 555.5556').should == '4055555556'
    end
  end
  
  describe '#base' do
    it 'should not be formatted (digits only)' do
      @klass.new('405-555-5555').base.should == '4055555555'
      @klass.new('(405) 555.5556').base.should == '4055555556'
    end
  end
  
  describe '#to_s' do
    it 'should return empty String if #phone is blank' do
      @klass.new('').to_s.should == ''
      @klass.new(nil).to_s.should == ''
    end
    
    it 'should format as (###) ###-#### by default' do
      @klass.new('1234567899').to_s.should == '(123) 456-7899'
    end
    
    it 'should format based on argument' do
      @klass.new('1234567899').to_s('(%A)%P-%S').
          should == '(123)456-7899'
      @klass.new('1234567899').to_s('%A.%P.%S').
          should == '123.456.7899'
    end
  end
end

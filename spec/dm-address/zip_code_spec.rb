require 'spec_helper'

describe DataMapper::Address::ZipCode do
  before(:all) do
    @klass = DataMapper::Address::ZipCode
  end
    
  describe '.new' do
    it 'should strip out non-digits' do
      @klass.new('12345-6789').should == '123456789'
      @klass.new('(12345 -67s80z').should == '123456780'
    end
  end
  
  describe '#base' do
    it 'should not be formatted (digits only)' do
      @klass.new('12345-6789').base.should == '123456789'
      @klass.new('(12345 -67s80z').base.should == '123456780'
    end
  end
  
  describe '#to_s' do
    it 'should return empty String if #phone is blank' do
      @klass.new('').to_s.should == ''
      @klass.new(nil).to_s.should == ''
    end
    
    it 'should format 5-digit code as #####' do
      @klass.new('12345').to_s.should == '12345'
    end
    
    it 'should format based on argument' do
      @klass.new('123456789').to_s.should == '12345-6789'
    end
  end
end

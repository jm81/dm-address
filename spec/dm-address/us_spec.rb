require 'spec_helper'
require 'dm-address/samples'

describe DataMapper::Address::US do
  before(:each) do
    @klass = DataMapper::Address::Spec::US
    
    @attrs = {
      :name => 'Jane Doe',
      :company => 'Widgets, Inc.',
      :street => '123 Lane Ave.',
      :street_2 => 'Suite A',
      :city => 'Nowhere',
      :state => 'OK',
      :postal_code => '123456789',
      :country => 'USA',
      :phone => '1235556789'
    }
    
    @address = @klass.new(@attrs)
  end
  
  def assert_validate(field, *values)
    values.each do |v|
      @address.__send__("#{field}=", v)
      @address.should be_valid
    end
  end
  
  def assert_not_validate(field, *values)
    values.each do |v|
      @address.__send__("#{field}=", v)
      @address.should_not be_valid
    end
  end

  it 'should be valid' do
    @address.should be_valid
  end
  
  describe '#name' do
    it 'should not be required' do
      assert_validate(:name, '', nil)
    end
  end
  
  describe '#street' do
    it 'should be required' do
      assert_not_validate(:street, '', nil)
    end
  end
  
  describe '#city' do
    it 'should be required' do
      assert_not_validate(:city, '', nil)
    end
  end
  
  describe '#state' do
    it 'should be required' do
      assert_not_validate(:state, '', nil)
    end
  end
  
  describe '#postal_code' do
    it 'should be required' do
      assert_not_validate(:postal_code, '', nil)
    end
    
    it 'should be 5 or 9 characters' do
      assert_not_validate(:postal_code, '1234', '123456', '12345678', '1234567890')
      assert_not_validate(:postal_code, '12345-678') # would be valid if dashes weren't stripped
      assert_validate(:postal_code, '12345', '123456789', '12345-6789')
    end
  end
  
  describe '#postal_code=' do
    it 'should strip out non-digits' do
      @address.postal_code = '12345-6789'
      @address.postal_code.should == '123456789'
      @address.postal_code = '(12345 -67s80z'
      @address.postal_code.should == '123456780'
    end
  end
  
  describe '#postal_code.to_s' do
    it 'should return empty String if #postal_code is blank' do
      @address.postal_code = ''
      @address.postal_code.to_s.should == ''
    end
    
    it 'should format 5-digit code as #####' do
      @address.postal_code = '12345'
      @address.postal_code.to_s.should == '12345'
    end
    
    it 'should format 9-digit code as #####-####' do
      @address.postal_code = '123456789'
      @address.postal_code.to_s.should == '12345-6789'
    end
  end
  
  describe '#country' do
    it 'should be required' do
      assert_not_validate(:country, '', nil)
    end
    
    it 'should default to USA' do
      @klass.new.country.should == 'USA'
    end
  end
  
  describe '#phone' do
    it 'should not be required' do
      assert_validate(:phone, '', nil)
    end
    
    it 'should be 10 characters' do
      assert_not_validate(:phone, '123456789', '12345678900')
      assert_not_validate(:phone, '123-456-89')
      assert_validate(:phone, '1234567890')
    end
  end
  
  describe '#phone=' do
    it 'should strip out non-digits' do
      @address.phone = '405-555-5555'
      @address.phone.should == '4055555555'
      @address.phone = '(405) 555.5556'
      @address.phone.should == '4055555556'
    end
  end
  
  describe '#phone.to_s' do
    it 'should return empty String if #phone is blank' do
      @address.phone = ''
      @address.phone.to_s.should == ''
    end
    
    it 'should format as (###) ###-####' do
      @address.phone = '1234567899'
      @address.phone.to_s.should == '(123) 456-7899'
    end
  end

  describe '#block' do
    @attrs = {
      :name => 'Jane Doe',
      :company => 'Widgets, Inc.',
      :street => '123 Lane Ave.',
      :street_2 => 'Suite A',
      :city => 'Nowhere',
      :state => 'OK',
      :postal_code => '12345-6789',
      :country => 'USA',
      :phone => '123-555-6789'
    }
    
    it 'should return nicely formatted block' do
      @address.block.should ==
        "Jane Doe\nWidgets, Inc.\n123 Lane Ave.\nSuite A\n" +
        "Nowhere, OK 12345-6789"
    end
    
    it 'should include optional #company (due to blank)' do
      @address.company = ''
      @address.block.should ==
        "Jane Doe\n123 Lane Ave.\nSuite A\n" +
        "Nowhere, OK 12345-6789"
    end
    
    it 'should include optional #street_2 (due to blank)' do
      @address.street_2 = ''
      @address.block.should ==
        "Jane Doe\nWidgets, Inc.\n123 Lane Ave.\n" +
        "Nowhere, OK 12345-6789"
    end
    
    it 'should optionally leave out #phone (due to blank)' do
      @address.phone = ''
      @address.block("\n", false, true).should ==
        "Jane Doe\nWidgets, Inc.\n123 Lane Ave.\nSuite A\n" +
        "Nowhere, OK 12345-6789"
    end
    
    it 'should optionally add #country (due to argument)' do
      @address.block("\n", true, false).should ==
        "Jane Doe\nWidgets, Inc.\n123 Lane Ave.\nSuite A\n" +
        "Nowhere, OK 12345-6789\nUSA"
    end
    
    it 'should optionally add #phone (due to argument)' do
      @address.block("\n", false, true).should ==
        "Jane Doe\nWidgets, Inc.\n123 Lane Ave.\nSuite A\n" +
        "Nowhere, OK 12345-6789\n(123) 555-6789"
    end
    
    it 'should accept alternate newline' do
      @address.block("<br />\n", false, false).should ==
        "Jane Doe<br />\nWidgets, Inc.<br />\n123 Lane Ave.<br />\nSuite A<br />\n" +
        "Nowhere, OK 12345-6789"
    end
  end
  
  describe '#created_at and #updated_at' do
    it 'should record timestamps' do
      @address.save
      @address.created_at.should be_kind_of(DateTime)
      @address.updated_at.should be_kind_of(DateTime)
    end
  end
  
  describe '#address_properties' do
    describe ':polymorphic option' do
      it 'should include Polymorphic module if true' do
        klass = Class.new
        klass.__send__(:include, DataMapper::Resource)
        klass.__send__(:include, DataMapper::Address::US)
        klass.address_properties(:polymorphic => true)
        klass.properties.named?(:addressable_class).should be_true
      end
      
      it 'should not include Polymorphic module if nil' do
        klass = Class.new
        klass.__send__(:include, DataMapper::Resource)
        klass.__send__(:include, DataMapper::Address::US)
        klass.address_properties
        klass.properties.named?(:addressable_class).should be_false
      end
    end
  end
end

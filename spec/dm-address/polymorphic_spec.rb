require File.join( File.dirname(__FILE__), '..', "spec_helper" )

DataMapper.setup(:default, 'sqlite3::memory:')
require 'dm-timestamps' # Only needed to make #created_at and #updated_at auto-update

module DataMapper::Address::Spec
  class Polymorphed
    include DataMapper::Resource
    include DataMapper::Address::Polymorphic
    property :id, Serial
    property :street, String
  end
  
  class Person
    include DataMapper::Resource
    
    property :id, Serial
    has n, :addresses, :class_name => 'DataMapper::Address::Spec::Polymorphed',
           :child_key => [:addressable_id], 
           DataMapper::Address::Spec::Polymorphed.addressable_class =>
               'DataMapper::Address::Spec::Person'
    
    property :name, String
  end
  
  Polymorphed.auto_migrate!
  Person.auto_migrate!
end

describe DataMapper::Address::Polymorphic do
  before(:each) do
    @parent_class = DataMapper::Address::Spec::Person
    @parent_class.all.destroy!
    @parent = @parent_class.create(:name => 'Jane Doe')
    
    @klass = DataMapper::Address::Spec::Polymorphed
    @klass.all.destroy!
    @address = @klass.create(:street => '123 Lane Ave.',
      :addressable_class => 'DataMapper::Address::Spec::Person',
      :addressable_id => @parent.id
    )
  end
  
  it 'should be valid' do
    # Sanity check only
    @parent.should be_valid
    @address.should be_valid
  end
  
  describe '#addressable' do
    it 'should return the parent' do
      @address.addressable.should == @parent
    end
    
    it 'should error if the class is unknown' do
      @address.addressable_class = 'DataMapper::Address::Spec::NoClass'
      lambda { @address.addressable }.should raise_error(NameError)
    end
    
    it 'should be nil if the id does not return a record' do
      @address.addressable_id = 0
      @address.addressable.should be_nil
    end
    
    it 'should remove a method identifier when determining class name' do
      @address.addressable_class = 'DataMapper::Address::Spec::Person#address'
      @address.addressable.should == @parent
    end
  end
  
  describe 'parent#addresses' do
    it 'should retrieve all addresses for this class/id' do
      address2 = @klass.create(:street => '123 Lane Ave.',
        :addressable_class => 'DataMapper::Address::Spec::Person',
        :addressable_id => @parent.id
      )
      
      @parent.addresses.should == [@address, address2]
    end
    
    it 'should not retrieve addresses for other classes' do
      address2 = @klass.create(:street => '123 Lane Ave.',
        :addressable_class => 'DataMapper::Address::Spec::NoClass',
        :addressable_id => @parent.id
      )
      
      @parent.addresses.should == [@address]
    end
  
    it 'should not retrieve addresses for other id' do
      address2 = @klass.create(:street => '123 Lane Ave.',
        :addressable_class => 'DataMapper::Address::Spec::Person',
        :addressable_id => 0
      )
      
      @parent.addresses.should == [@address]
    end
  end
end

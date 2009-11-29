require 'spec_helper'
require 'dm-address/samples'

describe DataMapper::Address::Preferred do
  before(:each) do
    @parent_class = DataMapper::Address::Spec::Person
    @parent_class.all.destroy!
    @parent = @parent_class.create(:name => 'Jane Doe')
    
    @klass = DataMapper::Address::Spec::Polymorphed
    @klass.all.destroy!
    
    @address1 = @klass.create(:street => '123 Lane Ave.',
      :addressable_class => @parent_class.name,
      :addressable_id => @parent.id
    )
    
    @address2 = @klass.create(:street => '123 Lane Ave.',
      :addressable_class => @parent_class.name,
      :addressable_id => @parent.id
    )
    
    @parent.update("shipping_id" => @address2.id)
  end
  
  it 'should be based on #{@preferred_name}_id' do
    address = @parent.shipping
    address.should_not be_nil
    address.id.should == @parent.shipping_id
  end
  
  it 'must belong to the parent record' do
    @parent.should_not be_nil # Sanity check
    @parent.shipping.addressable.should == @parent
  end
  
  it 'should default to first available' do
    @parent.update(:shipping_id => nil)
    @parent.shipping.should == @address1
  end
  
  it 'should be nil if none available' do
    @address1.update(:addressable_id => (@parent.id + 1))
    @address2.update(:addressable_class => "#{@parent_class.name}Other")
    @parent.shipping.should be_nil
  end
end

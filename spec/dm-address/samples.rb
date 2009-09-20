DataMapper.setup(:default, 'sqlite3::memory:')
require 'dm-timestamps' # Only needed to make #created_at and #updated_at auto-update

module DataMapper::Address::Spec
  class US
    include DataMapper::Resource
    include DataMapper::Address::US
    address_properties
  end

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
end

DataMapper.auto_migrate!

DataMapper.setup(:default, 'sqlite3::memory:')
require 'dm-migrations'

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
    include DataMapper::Address::Preferred
    
    property :id, Serial
    has n, :addresses, :model => 'DataMapper::Address::Spec::Polymorphed',
           :child_key => [:addressable_id], 
           DataMapper::Address::Spec::Polymorphed.addressable_class =>
               'DataMapper::Address::Spec::Person'
    
    property :name, String
    preferred_address :shipping
  end
end

DataMapper.auto_migrate!

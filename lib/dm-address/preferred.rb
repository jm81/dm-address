module DataMapper
  module Address
    # Helper for determining a Preferred (or default address) for something, for
    # example a billing address, where multiple addresses belong to record.
    #
    # Adds the following Class method when included:
    # 
    #     preferred_address(+method_name+)
    #
    # This will create an Integer property: +{method_name}_id+ and add an
    # instance method +method_name+.
    # 
    # For example:
    #
    #     class Person
    #       include DataMapper::Resource
    #       include DataMapper::Address::Preferred
    #       has n, :addresses
    #       preferred_address :default_billing
    #     end
    #     
    #     p = Person.new
    #     p.default_billing_id = Address.last.id
    #     p.default_billing # => Address.last
    #     
    # If +{method_name}_id+ is not set, the self.addresses.first is returned.
    module Preferred
      class << self
        def included(klass)
          klass.extend(ClassMethods)
        end
      end # class << self
      
      module ClassMethods
        
        # Setup a preferred address, including +{method_name}_id property
        #
        # ==== Parameters
        # method_name<~to_s>::
        #   Name of method used to access the preferred address.
        def preferred_address(method_name)
          property("#{method_name}_id".to_sym, Integer)
          
          define_method(method_name) do
            self.addresses.get(attribute_get("#{method_name}_id")) ||
            self.addresses.first
          end
        end
      end # module ClassMethods
      
    end # module Preferred
  end # module Address
end # module DataMapper

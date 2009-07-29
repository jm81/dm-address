module DataMapper
  module Address
    # Add fields to an Address class (such as one that includes Address::US)
    # to allow for roughly polymorphic associations, belonging to other classes.
    # (See http://pastie.org/214893). Including this module adds two properties:
    # +addressable_class+ and +addressable_id+, and one method, +addressable+,
    # for accessing the parent record.
    # 
    # To use (in Address class):
    # 
    #     include DataMapper::Address::Polymorphic
    #
    # In parent class, something along the lines of:
    #
    #     has n, :addresses, :class_name => 'Address',
    #            :child_key => [:addressable_id], 
    #            Address.addressable_class => 'ParentModel'
    module Polymorphic
      class << self
        # Add :addressable_class and :addressable_id properties
        def included(klass)
          klass.__send__(:property, :addressable_class, String)
          klass.__send__(:property, :addressable_id, Integer)
        end
      end # class << self
     
      
      # Return the addressable (that is, parent) record.
      def addressable
        parent_class_name = attribute_get(:addressable_class)
        # Remove a trailing method reference
        parent_split = parent_class_name.to_s.split('#')
        parent_class_name = parent_split[0..-2].join('#') if parent_split.length > 1
        return nil if parent_class_name.blank?
        parent_class = Object.full_const_get(parent_class_name)
        parent_class.get(attribute_get(:addressable_id))
      end
      
    end # module Polymorphic
  end # module Address
end # module DataMapper

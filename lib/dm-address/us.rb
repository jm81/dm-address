module DataMapper
  module Address
    # Include in a DataMapper::Resource model to add fields and methods for
    # a US-style address.
    module US
      DEFAULT_REQUIRED_FIELDS = [
        :street, :city, :state, :postal_code, :country
      ]
      
      class << self
        def included(klass)
          klass.extend(ClassMethods)
        end
      end # class << self
      
      module ClassMethods
        
        # Setup properties. Already added properties are not overriden.
        # options:
        # - +prefix+: Add a prefix to field names
        # - +required_fields+: Override DataMapper::Address.config[:us_required_fields]
        def address_properties(options = {})
          reqs = options[:required_fields] || 
                 DataMapper::Address.config[:us_required_fields] || 
                 DEFAULT_REQUIRED_FIELDS
          
          [
            [:id, DataMapper::Types::Serial],
            [:name, String, {:length => 100}],
            [:company, String, {:length => 100}],
            [:street, String, {:length => 100}],
            [:street_2, String],
            [:city, String, {:length => 100}],
            [:state, String, {:length => 2}],
            [:postal_code, DataMapper::Types::ZipCode, {:format => :zip_code}],
            [:country, String, {:nullable => false, :length => 50, :default => 'USA'}],
            [:phone, DataMapper::Types::PhoneNumber, {:format => :phone_number}],
            [:created_at, DateTime],
            [:updated_at, DateTime]
          ].each do |args|
            unless self.properties.named?(args[0])
              args[0] = "#{options[:prefix]}#{args[0]}" if options[:prefix]
              args[2] ||= {}
              args[2][:required] = reqs.include?(args[0])
              self.property(*args)
            end
          end
          
          if options[:polymorphic]
            include(DataMapper::Address::Polymorphic)
          end
        end
      end # module ClassMethods
      
      # Nicely formatted address block (optionally includes country and phone)
      def block(newline = "\n",
            include_country = DataMapper::Address.config[:include_country],
            include_phone = DataMapper::Address.config[:include_phone])
        
        fields = []
        %w{ name company street street_2 }.each do |fld|
          value = attribute_get(fld)
          fields << value unless value.blank?
        end
        fields << "#{self.city}, #{self.state} #{self.postal_code.to_s}"
        fields << self.country if include_country
        fields << self.phone.to_s if include_phone && !self.phone.blank?
        fields.join(newline)
      end
      
    end # module US
  end # module Address
end # module DataMapper

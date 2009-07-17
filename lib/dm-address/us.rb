module DataMapper
  module Address
    # Include in a DataMapper::Resource model to add fields and methods for
    # a US-style address.
    module US
      class << self
        def included(klass)
          klass.extend(ClassMethods)
        end
      end # class << self
      
      module ClassMethods
        def address_properties
          # Set default properties; already added properties are not overriden.
          [
            [:id, DataMapper::Types::Serial],
            [:name, String, {:nullable => true, :length => 100}],
            [:company, String, {:nullable => true, :length => 100}],
            [:street, String, {:nullable => false, :length => 100}],
            [:street_2, String],
            [:city, String, {:nullable => false, :length => 100}],
            [:state, String, {:nullable => false, :length => 2}],
            [:postal_code, DataMapper::Types::ZipCode, {:nullable => false,
                :format => Proc.new { |zc| zc.nil? || zc.length == 5 || zc.length == 9 },
                :messages => { :format => "Postal code should be 5 digits or 9 digits (ZIP+4)" }}],
            [:country, String, {:nullable => false, :length => 50, :default => 'USA'}],
            [:phone, DataMapper::Types::PhoneNumber, {:nullable => true,
                 :format => Proc.new { |ph| ph.blank? || ph.length == 10 },
                 :messages => { :format => "Phone number should be 10 digits (include area code)" }}],
            [:created_at, DateTime],
            [:updated_at, DateTime]
          ].each do |args|
            unless self.properties.has_property?(args[0])
              self.property(*args)
            end
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
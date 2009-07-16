module DataMapper
  module Types
    class PhoneNumber < DataMapper::Type
      primitive String
 
      def self.load(value, property)
        if value.nil?
          nil
        elsif value.is_a?(String)
          DataMapper::Address::PhoneNumber.new(value)
        else
          raise ArgumentError.new("+value+ must be nil or a String")
        end
      end
 
      def self.dump(value, property)
        return nil if value.nil?
        value.base
      end
 
      def self.typecast(value, property)
        value.kind_of?(DataMapper::Address::PhoneNumber) ?
            value :
            load(value, property)
      end
    end # class PhoneNumber
  end # module Types
end # module DataMapper

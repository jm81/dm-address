module DataMapper
  class Property
    class PhoneNumber < String
      def primitive?(value)
        super || value.kind_of?(::DataMapper::Address::PhoneNumber)
      end

      def load(value)
        case value
          when ::DataMapper::Address::PhoneNumber then value
          when ::String then DataMapper::Address::PhoneNumber.new(value)
          else
            nil
        end
      end
 
      def dump(value)
        case value
          when ::DataMapper::Address::PhoneNumber then value.to_str
          when ::String then value
          else
            nil
        end
      end
    end # class PhoneNumber
  end # module Property
end # module DataMapper

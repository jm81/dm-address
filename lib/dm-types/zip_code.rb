module DataMapper
  class Property
    class ZipCode < String
      def primitive?(value)
        super || value.kind_of?(::DataMapper::Address::ZipCode)
      end

      def load(value)
        case value
          when ::DataMapper::Address::ZipCode then value
          when ::String then DataMapper::Address::ZipCode.new(value)
          else
            nil
        end
      end

      def dump(value)
        case value
          when ::DataMapper::Address::ZipCode then value.to_str
          when ::String then value
          else
            nil
        end
      end
    end # class ZipCode
  end # module Property
end # module DataMapper

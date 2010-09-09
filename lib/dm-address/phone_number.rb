module DataMapper
  module Address
    class PhoneNumber < String
      DEFAULT_FORMAT = '(%A) %P-%S'
      
      # Remove all non-digits from given phone number
      def initialize(s)
        super((s || '').to_str.gsub(/\D+/, ''))
      end
      
      # %A is area code, %P is prefix, %S is last 4 digits (suffix)
      # Default is "(%A) %P-%S" -> (###) ###-####
      def to_s(format = nil)
        unless format
          format = DataMapper::Address.config[:phone_format] || DEFAULT_FORMAT
        end
        return '' if to_str.empty?
        format.gsub(/\%A/, to_str[0..2]).
               gsub(/\%P/, to_str[3..5]).
               gsub(/\%S/, to_str[6..9])
      end
    end # class PhoneNumber
  end # module Address
end # module DataMapper

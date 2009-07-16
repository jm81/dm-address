module DataMapper
  module Address
    class PhoneNumber < String
      DEFAULT_FORMAT = '(%A) %P-%S'
      
      # Remove all non-digits from given phone number
      def initialize(s)
        super((s || '').gsub(/\D+/, ''))
      end
      
      alias base to_s
      
      # %A is area code, %P is prefix, %S is last 4 digits (suffix)
      # Default is "(%A) %P-%S" -> (###) ###-####
      def to_s(format = nil)
        unless format
          format = DEFAULT_FORMAT
        end
        return '' if base.nil? || base.empty?
        format.gsub(/\%A/, base[0..2]).
               gsub(/\%P/, base[3..5]).
               gsub(/\%S/, base[6..9])
      end
    end # class PhoneNumber
  end # module Address
end # module DataMapper

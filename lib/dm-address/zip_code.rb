module DataMapper
  module Address
    class ZipCode < String
      # Remove all non-digits from given zip code
      def initialize(s)
        super((s || '').gsub(/\D+/, ''))
      end
      
      alias base to_s
      
      # ZipCode formatted as #####-#### or #####
      def to_s(format = nil)
        return '' if base.nil? || base.empty?
        return base if base.length == 5
        "#{base[0..4]}-#{base[5..8]}"
      end
    end # class ZipCode
  end # module Address
end # module DataMapper

module DataMapper
  module Address
    class ZipCode < String
      # Remove all non-digits from given zip code
      def initialize(s)
        super((s || '').to_str.gsub(/\D+/, ''))
      end

      # ZipCode formatted as #####-#### or #####
      def to_s(format = nil)
        return '' if to_str.empty?
        return to_str if to_str.length == 5
        "#{to_str[0..4]}-#{to_str[5..8]}"
      end
    end # class ZipCode
  end # module Address
end # module DataMapper

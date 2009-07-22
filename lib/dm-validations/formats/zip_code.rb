module DataMapper
  module Validate
    module Format
      module ZipCode
 
        def self.included(base)
          DataMapper::Validate::FormatValidator::FORMATS.merge!(
            :zip_code => [
                Proc.new { |zc| zc.blank? || zc.length == 5 || zc.length == 9 },
                lambda { |field, value| '%s should be 5 digits or 9 digits (ZIP+4)'.t(value) }
            ]
          )
        end
      end # module ZipCode
    end # module Format
  end # module Validate
end # module DataMapper

DataMapper::Validate::FormatValidator.__send__(:include, DataMapper::Validate::Format::ZipCode)

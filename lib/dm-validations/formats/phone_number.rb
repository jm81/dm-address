module DataMapper
  module Validate
    module Format
      module PhoneNumber
 
        def self.included(base)
          DataMapper::Validate::FormatValidator::FORMATS.merge!(
            :phone_number => [
                Proc.new { |ph| ph.blank? || ph.length == 10 },
                lambda { |field, value| '%s should be 10 digits (include area code)'.t(value) }
            ]
          )
        end
      end # module PhoneNumber
    end # module Format
  end # module Validate
end # module DataMapper

DataMapper::Validate::FormatValidator.__send__(:include, DataMapper::Validate::Format::PhoneNumber)

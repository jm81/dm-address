require 'dm-core'
require 'dm-timestamps'
require 'dm-types'
require 'dm-validations'

# Require dm-address files
%w{ phone_number zip_code polymorphic preferred us version }.each do |file|
  require 'dm-address/' + file
end

module DataMapper
  module Address
    DEFAULTS = {
      :phone_format => PhoneNumber::DEFAULT_FORMAT.dup,
      :include_country => false,
      :include_phone => false,
      :us_required_fields => US::DEFAULT_REQUIRED_FIELDS.dup
    }
    
    class << self
      # Address::config method returns Hash that can be edited.
      def config
        @config ||= DEFAULTS.dup
      end
    end
  end # module Address
end # module DataMapper

if defined?(Merb::Plugins)
  # Make config accessible through Merb's Merb::Plugins.config hash
  Merb::Plugins.config[:dm_address] = DataMapper::Address.config
end

# Require dm-types files
%w{ phone_number zip_code }.each do |file|
  require 'dm-types/' + file
end

# Require dm-validations/formats files
%w{ phone_number zip_code }.each do |file|
  require 'dm-validations/formats/' + file
end

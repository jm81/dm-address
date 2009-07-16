require 'dm-core'

# Require dm-address files
%w{ phone_number zip_code }.each do |file|
  require File.dirname(__FILE__) + '/dm-address/' + file
end

module DataMapper
  module Address
    DEFAULTS = {
      :phone_format => PhoneNumber::DEFAULT_FORMAT
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
%w{ phone_number }.each do |file|
  require File.dirname(__FILE__) + '/dm-types/' + file
end


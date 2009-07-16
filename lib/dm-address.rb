# Require dm-address files
%w{ phone_number }.each do |file|
  require File.dirname(__FILE__) + '/dm-address/' + file
end

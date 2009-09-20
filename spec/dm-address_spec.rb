require 'spec_helper'

describe DataMapper::Address do
  describe ".config" do
    before(:each) do
      # Force to default state
      DataMapper::Address.instance_variable_set(:@config, nil)
    end
    
    after(:all) do
      # Force to default state for other specs
      DataMapper::Address.instance_variable_set(:@config, nil)
    end
    
    it 'should initialize with DEFAULTS' do
      DataMapper::Address.config.should == DataMapper::Address::DEFAULTS
    end
    
    it 'should be writable' do
      DataMapper::Address.config[:example] = 1
      DataMapper::Address.instance_variable_get(:@config)[:example].should == 1
    end
  end
end

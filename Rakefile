require 'rubygems'
require 'rake'
require File.join(File.dirname(__FILE__), 'lib', 'dm-address', 'version')

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = "jm81-dm-address"
    gem.version = DataMapper::Address::VERSION.dup
    gem.summary = %Q{Add address related fields to a DataMapper model}
    gem.description = <<EOF
Add address fields to a DataMapper model. This includes optional validations,
and additional DM types for ZipCode and PhoneNumber.
EOF
    gem.email = "jmorgan@morgancreative.net"
    gem.homepage = "http://github.com/jm81/dm-address"
    gem.authors = ["Jared Morgan"]
    gem.add_dependency('dm-core', '~> 1.0.0')
    gem.add_dependency('dm-timestamps', '~> 1.0.0')
    gem.add_dependency('dm-types', '~> 1.0.0')
    gem.add_dependency('dm-validations', '~> 1.0.0')
    gem.add_development_dependency('dm-migrations', '~> 1.0.0')
    # gem is a Gem::Specification... see http://www.rubygems.org/read/chapter/20 for additional settings
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts "Jeweler (or a dependency) not available. Install it with: sudo gem install jeweler"
end

require 'spec/rake/spectask'
Spec::Rake::SpecTask.new(:spec) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.spec_files = FileList['spec/**/*_spec.rb']
end

Spec::Rake::SpecTask.new(:rcov) do |spec|
  spec.libs << 'lib' << 'spec'
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end


task :default => :spec

require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  if File.exist?('VERSION.yml')
    config = YAML.load(File.read('VERSION.yml'))
    version = "#{config[:major]}.#{config[:minor]}.#{config[:patch]}"
  else
    version = ""
  end

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "dm-address #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


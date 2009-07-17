# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{dm-address}
  s.version = "0.1.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Jared Morgan"]
  s.date = %q{2009-07-17}
  s.email = %q{jmorgan@morgancreative.net}
  s.extra_rdoc_files = [
    "LICENSE",
     "README.rdoc"
  ]
  s.files = [
    ".document",
     ".gitignore",
     "LICENSE",
     "README.rdoc",
     "Rakefile",
     "VERSION",
     "lib/dm-address.rb",
     "lib/dm-address/phone_number.rb",
     "lib/dm-address/us.rb",
     "lib/dm-address/zip_code.rb",
     "lib/dm-types/phone_number.rb",
     "lib/dm-types/zip_code.rb",
     "spec/dm-address/phone_number_spec.rb",
     "spec/dm-address/us_spec.rb",
     "spec/dm-address/zip_code_spec.rb",
     "spec/dm-address_spec.rb",
     "spec/dm-types/phone_number_spec.rb",
     "spec/dm-types/zip_code_spec.rb",
     "spec/spec_helper.rb"
  ]
  s.homepage = %q{http://github.com/jm81/dm-address}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.4}
  s.summary = %q{TODO}
  s.test_files = [
    "spec/dm-address/phone_number_spec.rb",
     "spec/dm-address/us_spec.rb",
     "spec/dm-address/zip_code_spec.rb",
     "spec/dm-address_spec.rb",
     "spec/dm-types/phone_number_spec.rb",
     "spec/dm-types/zip_code_spec.rb",
     "spec/spec_helper.rb"
  ]

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<extlib>, [">= 0"])
      s.add_runtime_dependency(%q<dm-core>, [">= 0"])
      s.add_runtime_dependency(%q<dm-types>, [">= 0"])
      s.add_runtime_dependency(%q<dm-validations>, [">= 0"])
    else
      s.add_dependency(%q<extlib>, [">= 0"])
      s.add_dependency(%q<dm-core>, [">= 0"])
      s.add_dependency(%q<dm-types>, [">= 0"])
      s.add_dependency(%q<dm-validations>, [">= 0"])
    end
  else
    s.add_dependency(%q<extlib>, [">= 0"])
    s.add_dependency(%q<dm-core>, [">= 0"])
    s.add_dependency(%q<dm-types>, [">= 0"])
    s.add_dependency(%q<dm-validations>, [">= 0"])
  end
end

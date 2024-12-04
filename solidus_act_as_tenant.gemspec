# frozen_string_literal: true

require_relative 'lib/solidus_act_as_tenant/version'

Gem::Specification.new do |spec|
  spec.name = 'solidus_act_as_tenant'
  spec.version = SolidusActAsTenant::VERSION
  spec.authors = ['Ikraam Ghoor']
  spec.email = 'consult.ikraam@gmail.com'

  spec.summary = 'Adds tenant functionality to solidus using the row level acts_as_tenant gem'
  spec.description = 'Adds tenant functionality to solidus using the row level acts_as_tenant gem'
  spec.homepage = 'https://github.com/solidusio-contrib/solidus_act_as_tenant#readme'
  spec.license = 'BSD-3-Clause'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/solidusio-contrib/solidus_act_as_tenant'
  spec.metadata['changelog_uri'] = 'https://github.com/solidusio-contrib/solidus_act_as_tenant/blob/main/CHANGELOG.md'

  spec.required_ruby_version = Gem::Requirement.new('>= 2.5', '< 4')

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  files = Dir.chdir(__dir__) { `git ls-files -z`.split("\x0") }

  spec.files = files.grep_v(%r{^(test|spec|features)/})
  spec.test_files = files.grep(%r{^(test|spec|features)/})
  spec.bindir = "exe"
  spec.executables = files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'acts_as_tenant', '~> 1.0.1'
  spec.add_dependency 'solidus_core', ['>= 2.0.0', '< 5']
  spec.add_dependency 'solidus_support', '~> 0.5'

  spec.add_development_dependency 'solidus_dev_support', '~> 2.9'
end

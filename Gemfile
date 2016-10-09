source 'https://rubygems.org'
ruby '2.3.1'

gem 'rake'
gem 'puppet-lint'
gem 'puppet-doc-lint'
gem 'rspec'
gem 'rspec-puppet'

puppetversion = ENV.key?('PUPPET_VERSION') ? "~> #{ENV['PUPPET_VERSION']}" : ['>= 3.8']
gem 'puppet', puppetversion, :require => false
gem 'puppetlabs_spec_helper'
gem 'beaker'
gem 'beaker-rspec'
gem 'puppet-lint'
gem 'puppet-syntax'
gem 'rspec-puppet-facts'
gem 'serverspec'

# Extra Puppet-lint gems
gem 'puppet-lint-appends-check',            :require => false
gem 'puppet-lint-version_comparison-check', :require => false
gem 'puppet-lint-unquoted_string-check',    :require => false
gem 'puppet-lint-undef_in_function-check',  :require => false
gem 'puppet-lint-trailing_comma-check',     :require => false
gem 'puppet-lint-leading_zero-check',       :require => false
gem 'puppet-lint-file_ensure-check',        :require => false
gem 'puppet-lint-empty_string-check',       :require => false

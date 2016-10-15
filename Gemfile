source 'https://rubygems.org'

puppetversion = ENV.key?('PUPPET_VERSION') ? "#{ENV['PUPPET_VERSION']}" : ['>= 3.8']

gem 'rake'
gem 'puppet',                 puppetversion, :require => false
gem 'puppet-syntax'
gem 'puppet-lint'
gem 'puppet-doc-lint'
gem 'rspec'
gem 'rspec-puppet'
gem 'rspec-puppet-facts'
gem 'puppetlabs_spec_helper'
gem 'beaker'
gem 'beaker-rspec'
gem 'serverspec'
gem 'metadata-json-lint'
gem 'parallel_tests'
gem 'puppet-blacksmith'
gem 'json_pure',              '<= 2.0.1', :require => false if RUBY_VERSION < '2.0.0'

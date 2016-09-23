Gem::Specification.new do |spec|
  spec.name          = 'lita-salesforce'
  spec.version       = '0.1.0'
  spec.authors       = ['Chulki Lee']
  spec.email         = ['chulki.lee@gmail.com']
  spec.description   = 'a lita handler that talks to Salesforce'
  spec.summary       = 'a lita handler that talks to Salesforce'
  spec.homepage      = 'http://github.com/chulkilee/lita-salesforce'
  spec.license       = 'MIT'
  spec.metadata      = { 'lita_plugin_type' => 'handler' }

  spec.files         = Dir['lib/**/*', 'locales/**/*', 'templates/**/*']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'lita', '>= 4.6'
  spec.add_runtime_dependency 'restforce', '>= 2.1.1'

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'pry-byebug'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rack-test'
  spec.add_development_dependency 'rspec', '>= 3.0.0'
  spec.add_development_dependency 'rubocop', '>= 0.34.2'
  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'coveralls'
end

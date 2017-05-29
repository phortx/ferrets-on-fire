$:.push File.expand_path('../lib', __FILE__)

require 'ferrets_on_fire/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'ferrets_on_fire'
  s.version     = FerretsOnFire::VERSION
  s.authors     = ['phortx']
  s.email       = ['benny@itws.de']
  s.homepage    = 'https://github.com/phortx/ferrets-on-fire'
  s.summary     = 'Supercharge your CLI'
  s.description = 'Supercharge your CLI tools. This gem helps you to write powerful CLI tools without caring about the clutter'
  s.license     = 'MIT'

  s.files = Dir['lib/**/*', 'MIT-LICENSE', 'README.md']

  s.add_dependency 'micon', '~> 0.1'
  s.add_dependency 'highline', '~> 1.7'
  s.add_dependency 'colorize', '~> 0.8'
  s.add_dependency 'gli', '~> 2.15'
  s.add_dependency 'rugged', '~> 0.25'
  s.add_dependency 'tty', '~> 0.7.0'

  s.add_development_dependency 'rspec', '~> 3.5.0'
end

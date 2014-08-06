Gem::Specification.new do |s|
  s.name = "avatax"
  s.version = "0.0.1"
  s.summary = "Libaray for accessing Avalara's tax and address services"
  s.authors = ['Anya Stettler', 'Jeff Weiss']
  s.email = 'anya.stettler@avalara.com'
  s.require_paths = ['lib']
  s.files = Dir['LICENSE', 'README.md', 'lib/**/*']
  s.license = 'Apache-2.0'
  s.add_dependency 'json', '~> 1.8'
  s.add_dependency 'rest-client', '~> 1.6'
  s.add_dependency 'addressable', '~> 2.3'
end

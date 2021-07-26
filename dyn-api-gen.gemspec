Gem::Specification.new do |s|
  s.name        = 'dyn-api-gen'
  s.version     = '0.0.1'
  s.date        = Time.now.strftime('%Y-%m-%d')
  s.summary     = 'Dynamic API client generator. Aims to follow OpenAPI + JSON API standards'
  s.authors     = ['Emiliano Mancuso']
  s.email       = ['emiliano.mancuso@gmail.com', 'developers@carwow.co.uk']
  s.homepage    = 'http://github.com/carwow/dyn-api-gen'
  s.license     = 'MIT'

  s.files = Dir[
    'README.md',
    'rakefile',
    'lib/**/*.rb',
    '*.gemspec'
  ]
  s.test_files = Dir['test/*.*']

  s.add_development_dependency 'test-unit', '~> 3.3'
end

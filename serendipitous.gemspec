Gem::Specification.new do |s|
  s.name        = 'serendipitous'
  s.version     = '0.0.2'
  s.date        = '2016-04-20'
  s.summary     = 'Creative query engine'
  s.description = 'An engine for creative feedback'
  s.authors     = ['Andrew Brown']
  s.email       = 'andrew@indentlabs.com'
  s.files       = [
    'lib/serendipitous.rb',
    'lib/serendipitous/railtie.rb',
    'lib/serendipitous/content.rb',
    'lib/serendipitous/content_service.rb',
    'lib/serendipitous/question_service.rb',
    'lib/serendipitous/suggestion_service.rb',
    'lib/serendipitous/prompt_service.rb',
    'lib/serendipitous/template_service.rb'
  ]
  s.homepage    = 'http://indentlabs.com/serendipitous'
  s.license     = 'MIT'
end

require 'serendipitous/railtie' if defined?(Rails)
require 'serendipitous/concern' if defined?(Rails)

require 'serendipitous/content'

require 'serendipitous/question_service'
require 'serendipitous/suggestion_service'
require 'serendipitous/prompt_service'
require 'serendipitous/content_service'
require 'serendipitous/template_service'

# Gem interface
module Serendipitous
  def self.question(content)
    QuestionService.question(content)
  end

  def self.suggestion(_content)
  end

  def self.prompt(_content)
  end
end

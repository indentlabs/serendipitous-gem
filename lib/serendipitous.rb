require 'serendipitous/content'

require 'serendipitous/question_service'
require 'serendipitous/suggestion_service'
require 'serendipitous/prompt_service'
require 'serendipitous/content_service'

# Gem interface
class Serendipitous
  def self.question(content)
    QuestionService.question(content)
  end

  def self.suggestion(_content)
  end

  def self.prompt(_content)
  end

  # maybe
  # def self.problems content
  # end
end

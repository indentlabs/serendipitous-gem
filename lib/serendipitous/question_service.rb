# TODO: scope this class (and all other classes) into Serendipity:: namespace
# Takes a look at a Content and asks a question about it
class QuestionService
  def self.question(content)
    # TODO: Make "What is" a token based on content type + field
    #       e.g. location-reference --> "Where is _____?""
    "What is #{content.title}'s #{answerable_fields_for(content).keys.sample.to_s.downcase.tr('_', ' ')}?"
  end

  def self.answerable_fields_for(content)
    # TODO: aggregate QuestionServiceLayer responses here
    ContentService.unanswered_fields(content)
  end

end

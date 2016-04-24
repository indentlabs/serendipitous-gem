# TODO: scope this class (and all other classes) into Serendipity:: namespace
# Takes a look at a Content and asks a question about it
class QuestionService
  def self.question(content)
    answerable_fields = ContentService.unanswered_fields(content)

    # TODO: Make "What is" a token based on content type + field
    "What is #{content.title}'s #{answerable_fields.sample.downcase.tr('_', ' ')}?"
  end

  def self.answerable_fields_for(content)
    # TODO: make this smarter
    QuestionService.unanswered_fields(content)
  end
end

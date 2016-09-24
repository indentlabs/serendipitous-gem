require 'i18n'

# TODO: scope this class (and all other classes) into Serendipity:: namespace
# Takes a look at a Content and asks a question about it
class QuestionService
  def self.question(content)
    # TODO: Make "What is" a token based on content type + field
    #       e.g. location-reference --> "Where is _____?""
    field_to_answer = answerable_fields_for(content).keys.sample

    {
      field:    field_to_answer,
      question: I18n.translate(field_to_answer, scope: [:serendipitous_questions, :attributes, content.model_name], name: content.data['name'])
    }
  end

  def self.answerable_fields_for(content)
    # TODO: aggregate QuestionServiceLayer responses here
    ContentService.unanswered_fields(content)
  end
end

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
      question: build_question(content, field_to_answer)
    }
  end

  def self.answerable_fields_for(content)
    # TODO: aggregate QuestionServiceLayer responses here
    ContentService.unanswered_fields(content)
  end

  def self.build_question(content, field_to_answer)
    I18n.translate "attributes.#{content.model_name}.#{field_to_answer}",
      scope: :serendipitous_questions,
      name: content.data['name']
  end
end

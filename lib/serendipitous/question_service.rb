# TODO: scope this class (and all other classes) into Serendipity:: namespace
# Takes a look at a Content and asks a question about it
class QuestionService
  def self.question(content)
    # TODO: Make "What is" a token based on content type + field
    #       e.g. location-reference --> "Where is _____?""
    field_to_answer = answerable_fields_for(content).keys.sample
    build_question content, field_to_answer
  end

  def self.answerable_fields_for(content)
    # TODO: aggregate QuestionServiceLayer responses here
    ContentService.unanswered_fields(content)
  end

  def self.build_question content, field
    type = field_type(field)
    template = questions_for(type)
    template
  end

  def self.field_type value
    # TODO: piggyback on Watson NLC for now
    'Character'
  end

  # TODO: stick this in internationalized yaml
  # TODO: make this smarter
  def self.questions_for field
    case field_type(field)
    when 'Character'
      [
        # e.g. field=best_friend -> "Who is Alice's best friend?"
        "Who is [[title]]'s <<field>>?"
      ]
    when 'Location'
      [
        # e.g. field=hometown -> "Where is Alice's home town?"
        "Where is [[title]]'s <<field>>?"
      ]
    when 'Item'
      [
        # e.g. field=favorite_item -> "What is Alice's favorite item?"
        "What is [[title]]'s <<field>>?"
      ]
    when 'Data'
      [
        # e.g. field=height -> "What is Alice's height?"
        # TODO: special cases here:
        #       height -> "How tall is..."
        #       weight -> "How much does...weigh?"
        #       age    -> "How old is..."
        "What is [[title]]'s <<field>>?"
      ]
    else
      [
        'Dunno lol'
      ]
    end
  end
end

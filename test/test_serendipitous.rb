require 'minitest/autorun'
require 'serendipitous'

class SerendipitousTest < Minitest::Test
  # TODO: let(:content) { Content.new }
  def test_tests_are_working
    assert_equal true, true
  end

  # TODO: Break these out into their own model tests

  def test_content_for_adds_fields
    @content = Content.new({ some_new_field: 'awesome!', another_field: 'great!' })
    assert_equal @content.some_new_field, 'awesome!'
    assert_equal @content.another_field, 'great!'
  end

  def test_content_has_data # just reminder to add
    @content = Content.new({ title: 'Hello', description: 'World' })
    assert @content.title.length > 0
    assert @content.description.length > 0
  end

  # TODO: Break these out into their own service tests

  # Content Service
  def test_unanswered_fields_includes_blank_fields
    # TODO: mock and check specific fields
    @content = Content.new({ some_blank_field: '' })
    assert ContentService.unanswered_fields(@content).include? :some_blank_field
  end

  def test_unanswered_fields_excludes_filled_fields
    # TODO: mock and check specific fields
    @content = Content.new({title: 'Existing data'})
    refute ContentService.unanswered_fields(@content).include? :title
  end

  # def test_content_service_uses_field_whitelist
  #   # TODO: make this a setting
  #   @content = Content.new
  #   ContentService.unanswered_fields(@content).each do |field, value|
  #     assert ContentService.whitelisted_fields.include? field
  #   end
  # end

  def test_content_service_uses_field_blacklist
    # TODO: make this a setting
    @content = Content.new
    ContentService.unanswered_fields(@content).each do |field|
      refute ContentService.blacklisted_fields.include? field
    end
  end

  def test_blank_fields_are_unanswered
    @content = Content.new({ some_blank_field: '' })
    assert ContentService.unanswered_fields(@content).include? :some_blank_field
  end

  # Question Service

  def test_question_service_returns_a_question
    @content = Content.new({ title: 'Alice', best_friend: '', age: '', favorite_color: '', birthday: '', hometown: '' })
    question = QuestionService.question(@content)
    puts "Question is #{question}"
    refute question.empty?
  end

  # Suggestion Service

  def test_suggestion_service_returns_a_suggestion
    @content = Content.new
    refute SuggestionService.suggestion(@content).empty?
  end

  # PromptService

  def test_prompt_service_returns_a_prompt
    @content = Content.new
    refute PromptService.prompt(@content).empty?
  end
end

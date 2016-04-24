require 'minitest/autorun'
require 'serendipitous'

class Content
end

class SerendipitousTest < Minitest::Test
  # TODO: let(:content) { Content.new }
  def test_tests_are_working
    assert_equal true, true
  end

  # TODO: Break these out into their own model tests
  def test_content_has_title
    @content = Content.new
    assert @content.respond_to?(:title)
    assert @content.title.length > 0
  end

  def test_content_for_adds_fields
  end

  def test_content_has_data # just reminder to add
    @content = Content.new
    assert @content.respond_to?(:title)
    assert @content.description.length > 0
  end

  # TODO: Break these out into their own service tests

  # Content Service
  def test_unanswered_fields_includes_blank_fields
    # TODO: mock and check specific fields
    @content = Content.new
    assert ContentService.unanswered_fields(@content).include? 'some_blank_field'
  end

  def test_content_service_uses_field_whitelist
    # TODO: make this a setting
    @content = Content.new
    ContentService.unanswered_fields(@content).each do |field|
      assert ContentService.whitelisted_fields.include? field
    end
  end

  def test_content_service_uses_field_blacklist
    # TODO: make this a setting
    @content = Content.new
    ContentService.unanswered_fields(@content).each do |field|
      refute ContentService.blacklisted_fields.include? field
    end
  end

  def test_blank_fields_are_unanswered
    @content = Content.new
    assert ContentService.unanswered_fields(@content).include? 'some_blank_field'
  end

  # Question Service

  def test_question_service_returns_a_question
    @content = Content.new
    question = QuestionService.question(@content)
    puts "Question is #{question}"
    refute question.empty?
  end

  # Suggestion Service

  def test_suggestion_service_returns_a_suggestion
    @content = Content.new
    assert !SuggestionService.suggestion(@content).empty?
  end

  # PromptService

  def test_prompt_service_returns_a_prompt
    @content = Content.new
    assert !PromptService.prompt(@content).empty?
  end
end

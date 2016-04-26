require 'minitest/autorun'
require 'serendipitous'

class SerendipitousTest < Minitest::Test
  # TODO: let(:content) { Content.new }
  def test_tests_are_working
    assert_equal true, true
  end

  # TODO: Break these out into their own model tests

  def test_content_for_adds_fields
    @content = Content.new({ 'some_new_field' => 'awesome!', 'another_field' => 'great!' })
    assert_equal @content.data['some_new_field'], 'awesome!'
    assert_equal @content.data['another_field'], 'great!'
  end

  def test_content_has_data # just reminder to add
    @content = Content.new({ 'name' => 'Hello', 'description' => 'World' })
    assert @content.data.length > 0
  end

  # TODO: Break these out into their own service tests

  # Content Service
  def test_unanswered_fields_includes_blank_fields
    # TODO: mock and check specific fields
    @content = Content.new({ 'some_blank_field' => '' })
    assert ContentService.unanswered_fields(@content).include? 'some_blank_field'
  end

  def test_unanswered_fields_excludes_filled_fields
    # TODO: mock and check specific fields
    @content = Content.new({'name' => 'Existing data'})
    refute ContentService.unanswered_fields(@content).include? 'name'
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
    @content = Content.new({ 'some_blank_field' => '' })
    assert ContentService.unanswered_fields(@content).include? 'some_blank_field'
  end

  # Question Service

  def test_question_service_returns_a_question
    @content = Content.new({ 'name' => 'Alice', 'best_friend' => '', 'favorite_color' => '', 'birthday' => '', 'hometown' => '' })
    response = QuestionService.question(@content)
    puts "Question is #{response[:question]}"
    refute response[:question].empty?
  end

  def test_question_service_returns_the_field_asking_about
    @content = Content.new({ 'name' => 'Alice', 'best_friend' => '', 'favorite_color' => '', 'birthday' => '', 'hometown' => '' })
    response = QuestionService.question(@content)
    refute response[:field].empty?
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

  # TemplateService

  def test_replaces_content_name_in_template
    @content = Content.new({ 'name' => 'UNIQUE' })
    template = "This is [[name]]."
    response = TemplateService.perform_data_replacements(template, @content)
    assert_equal response, 'This is UNIQUE.'
  end

  def test_removes_brackets_correctly
    assert_equal TemplateService.send(:remove_brackets, '[[name]]'), 'name'
  end

  def test_replacement_for_looks_at_data
    @content = Content.new({ 'name' => 'UNIQUE' })
    assert_equal TemplateService.replacement_for('name', @content), 'UNIQUE'
  end
end

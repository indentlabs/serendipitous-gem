require 'minitest/autorun'
require 'serendipitous'
require 'i18n'

class QuestionServiceTest < Minitest::Test
  def setup
    I18n.load_path = Dir['test/en.yml']
  end

  def test_question_service_returns_a_question
    @content = Content.new('name' => 'Alice', 'best_friend' => '', 'model_name' => 'content')
    response = QuestionService.question(@content)
    assert_equal response[:question], "Who is Alice’s best friend?"
  end

  def test_question_service_returns_the_field_asking_about
    @content = Content.new('name' => 'Alice', 'best_friend' => '', 'model_name' => 'content')
    response = QuestionService.question(@content)
    assert_equal response[:field], 'best_friend'
  end
end

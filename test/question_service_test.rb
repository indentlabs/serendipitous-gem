require 'minitest/autorun'
require 'serendipitous'
require 'i18n'

class QuestionServiceTest < Minitest::Test
  def setup
    I18n.load_path = Dir['test/en.yml']
  end

  def test_question_service_returns_a_question
    @content = Content.new('name' => 'Alice', 'best_friend' => '', 'favorite_color' => '', 'birthday' => '', 'hometown' => '')
    response = QuestionService.question(@content)
    assert_match(/Alice/, response[:question])
    assert_match(/(best friend|favorite color|birthday|hometown)/, response[:question])
    refute response[:question].empty?
  end

  def test_question_service_returns_the_field_asking_about
    @content = Content.new('name' => 'Alice', 'best_friend' => '', 'favorite_color' => '', 'birthday' => '', 'hometown' => '')
    response = QuestionService.question(@content)
    assert_match(/(best_friend|favorite_color|birthday|hometown)/, response[:field])
    refute response[:field].empty?
  end
end

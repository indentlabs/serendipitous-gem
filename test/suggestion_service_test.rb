require 'minitest/autorun'
require 'serendipitous'

class SuggestionServiceTest < Minitest::Test
  def test_suggestion_service_returns_a_suggestion
    @content = Content.new
    refute SuggestionService.suggestion(@content).empty?
  end
end

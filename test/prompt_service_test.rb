require 'minitest/autorun'
require 'serendipitous'

class PromptServiceTest < Minitest::Test
  def test_prompt_service_returns_a_prompt
    @content = Content.new
    refute PromptService.prompt(@content).empty?
  end
end

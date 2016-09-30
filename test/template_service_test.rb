require 'minitest/autorun'
require 'serendipitous'

class TemplateServiceTest < Minitest::Test
  def test_replaces_content_name_in_template
    @content = Content.new('name' => 'UNIQUE')
    template = 'This is [[name]].'
    response = TemplateService.perform_data_replacements(template, @content)
    assert_equal response, 'This is UNIQUE.'
  end

  def test_removes_brackets_correctly
    assert_equal TemplateService.send(:remove_brackets, '[[name]]'), 'name'
  end

  def test_replacement_for_looks_at_data
    @content = Content.new('name' => 'UNIQUE')
    assert_equal TemplateService.replacement_for('name', @content), 'UNIQUE'
  end
end

require 'minitest/autorun'
require 'serendipitous'

class ContentServiceTest < Minitest::Test
  def setup
    I18n.load_path = Dir['test/en.yml']
  end

  def test_unanswered_fields_includes_blank_fields
    # TODO: mock and check specific fields
    @content = Content.new('some_blank_field' => '')
    assert ContentService.unanswered_fields(@content).include? 'some_blank_field'
  end

  def test_unanswered_fields_excludes_filled_fields
    # TODO: mock and check specific fields
    @content = Content.new('name' => 'Existing data')
    refute ContentService.unanswered_fields(@content).include? 'name'
  end

  def test_content_service_uses_field_blacklist
    # TODO: make this a setting
    @content = Content.new
    ContentService.unanswered_fields(@content).each do |field|
      refute ContentService.blacklisted_fields.include? field
    end
  end

  def test_blank_fields_are_unanswered
    @content = Content.new('some_blank_field' => '')
    assert ContentService.unanswered_fields(@content).include? 'some_blank_field'
  end
end

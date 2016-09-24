require 'minitest/autorun'
require 'serendipitous'

class ContentTest < Minitest::Test
  def test_content_for_adds_fields
    @content = Content.new('some_new_field' => 'awesome!', 'another_field' => 'great!')
    assert_equal @content.data['some_new_field'], 'awesome!'
    assert_equal @content.data['another_field'], 'great!'
  end

  def test_content_has_data # just reminder to add
    @content = Content.new('name' => 'Hello', 'description' => 'World')
    assert !@content.data.empty?
  end
end

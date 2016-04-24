# Temp Content class stand-in for notebook gem
class Content

  def self.for fields={}
    # TODO: dynamic content fields
    Content.new fields.merge({ some_blank_field: '' })
  end

  def title
    "Alice"
  end

  def description
    "Bob"
  end

  def some_blank_field
    ''
  end

  # TODO: real attributes

end
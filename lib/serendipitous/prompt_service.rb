# TODO: scope this class (and all other classes) into Serendipity:: namespace
# TODO: mix multiple pieces of content
# TODO: specify parameters such as genre, reading level, etc

# Looks at a piece of content and provides a writing prompt about it
class PromptService
  def self.prompt(content)
    "What is #{content}?"
  end
end

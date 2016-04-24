# TODO: scope this class (and all other classes) into Serendipity:: namespace
# TODO: ExternalDataLayer to base suggestions on real-world stats provided
#       elsewhere

# Looks at a piece of content and makes a suggestion on improving it
class SuggestionService
  def self.suggestion(content)
    "What is #{content}?"
  end
end

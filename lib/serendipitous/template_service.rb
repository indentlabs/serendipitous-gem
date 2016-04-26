# Template service
class TemplateService
  # Regex to determine whether a word is in template replacement format
  # e.g. [[user.name]] or [[day_of_week]]
  TOKEN_REGEX = /(\[\[[^\]]+\]\])/
  # TODO: Support nested template replacement [[e.g. another_user.title]] instead of [[title]]

  # Regex to find symbolic reductions
  SRAI_REGEX = /<<([^>]+)>>/
  # TODO: implement symbolic reductions

  def self.perform_data_replacements template, content
    template.gsub(TOKEN_REGEX) do |token|
      replacement_for(remove_brackets(token), content)
    end
  end

  def self.perform_symbolic_reductions template
    # template.gsub(SRAI_REGEX) do |srai|
    #   reduction_template = KeywordMatcherService.match_to_template srai
    #   replaced_template = TemplateReplacerService.replace_replacements reduction_template

    #   replaced_template
    # end
  end

  def self.replacement_for token, content
    content.data[token]
  end

  private

  def self.remove_brackets(token)
    token.sub(/^\[\[/, '')
      .sub(/\]\]$/, '')
  end

end

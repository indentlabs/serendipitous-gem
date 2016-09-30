require 'i18n'

# A layer of higher level methods on top of Content
class ContentService
  def self.unanswered_fields(content)
    content.data.select do |key, value|
      next if blacklisted_fields(content).include? key
      #next unless whitelisted_fields.include? key

      unanswered?(value)
    end
  end

  def self.unanswered?(field)
    # TODO: Compare against defaults
    field.nil? || field.length == 0
  end

  # TODO: make this smarter
  def self.whitelisted_fields
    @whitelisted_fields ||= %w(name description)
  end

  # TODO: make this smarter
  def self.blacklisted_fields(content)
    @blacklisted_fields = []
    @blacklisted_fields.concat [I18n.translate('serendipitous_questions.blacklist._')]
    @blacklisted_fields.concat [I18n.translate("serendipitous_questions.blacklist.#{content.model_name}")]
    @blacklisted_fields.concat ['model_name']
  end
end

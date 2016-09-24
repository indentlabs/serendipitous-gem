require 'i18n'

# A layer of higher level methods on top of Content
class ContentService
  def self.unanswered_fields(content)
    content.data.select do |key, value|
      next if blacklisted_fields.include? key
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
  def self.blacklisted_fields
    @blacklisted_fields = I18n.translate :blacklist, scope: [:serendipitous_questions, :default]
  end
end

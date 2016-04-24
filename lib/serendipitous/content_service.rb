# A layer of higher level methods on top of Content
class ContentService
  # def self.answerable_fields(content)
  #   unanswered_fields(content)
  # end

  def self.unanswered_fields(content)
    whitelisted_fields.select do |field|
      next if blacklisted_fields.include? field
      # TODO: this loop be wonky

      unanswered? content.send(field)
      # TODO: rescue these when they fail
    end
  end

  def self.unanswered?(field)
    # TODO: Compare against defaults
    field.length == 0
  end

  # TODO: make this smarter
  def self.whitelisted_fields
    %w(title description some_blank_field)
  end

  # TODO: make this smarter
  def self.blacklisted_fields
    %w(id user_id)
  end
end

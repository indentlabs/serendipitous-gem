require 'active_support/concern'
require 'serendipitous/railtie' if defined?(Rails)

require 'serendipitous/content'

require 'serendipitous/question_service'
require 'serendipitous/suggestion_service'
require 'serendipitous/prompt_service'
require 'serendipitous/content_service'
require 'serendipitous/template_service'

# Gem interface
module Serendipitous
  def self.question(content)
    QuestionService.question(content)
  end

  def self.suggestion(_content)
  end

  def self.prompt(_content)
  end

  module Concern
    extend ActiveSupport::Concern

    included do
      def question
        field_to_answer = answerable_fields.sample

        {
          field:    field_to_answer,
          question: build_question(field_to_answer)
        }
      end

      def build_question(field_to_answer)
        I18n.translate "attributes.#{model_name.param_key}.#{field_to_answer}",
          scope: :serendipitous_questions,
          name: name
      end

      def answerable_fields
        unanswered_fields
      end

      def unanswered_fields
        attributes.keys.select do |name|
          next if self.class.blacklist.include? name
          unanswered?(name)
        end
      end

      def unanswered?(field)
        send(field).blank?
      end
    end

    module ClassMethods
      def whitelist
        column_names - blacklist
      end

      def blacklist
        [
          [ I18n.translate('serendipitous_questions.blacklist._') ],
          [ I18n.translate("serendipitous_questions.blacklist.#{model_name.param_key}", default: '').presence ],
          [ column_names.keep_if { |a| a =~ /_id/ } ],
          [ 'created_at', 'updated_at'],
          [ 'id' ]
        ].flatten.compact
      end
    end
  end
end

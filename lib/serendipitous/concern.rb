begin
  require 'active_support/concern'
rescue
  return
end

module Serendipitous
  module Concern
    extend ActiveSupport::Concern

    included do
      def question(field_to_answer = nil)
        return if field_to_answer.nil? && answerable_fields.empty?

        field_to_answer ||= answerable_fields.sample

        {
          field:    field_to_answer,
          question: build_question(field_to_answer)
        }
      end

      def build_question(field_to_answer)
        question = I18n.translate "attributes.#{model_name.param_key}.#{field_to_answer}",
                                  scope: :serendipitous_questions,
                                  name: name,
                                  attribute: field_to_answer.to_s,
                                  default: ''
        return question unless question.blank?

        question = I18n.translate "attributes.#{model_name.param_key}._",
                                  scope: :serendipitous_questions,
                                  name: name,
                                  attribute: field_to_answer.to_s,
                                  default: ''
        return question unless question.blank?

        question = I18n.translate "attributes._.#{field_to_answer}",
                                  scope: :serendipitous_questions,
                                  name: name,
                                  attribute: field_to_answer.to_s,
                                  default: ''
        return question unless question.blank?

        question = I18n.translate 'default',
                       scope: :serendipitous_questions,
                       name: name,
                       attribute: field_to_answer.to_s
                       default: ''
        return question unless question.blank?
        return nil
      end

      def answerable_fields
        unanswered_fields
      end

      def unanswered_fields
        attributes.keys.select do |k|
          self.class.whitelisted?(k.to_sym) && unanswered?(k.to_sym)
        end.map(&:to_sym)
      end

      def unanswered?(field)
        send(field).blank?
      end
    end

    module ClassMethods
      def whitelist
        column_names.map(&:to_sym) - blacklist
      end

      def whitelisted?(field_name)
        whitelist.include? field_name.to_sym
      end

      def blacklist
        [
          [column_names.select { |a| a =~ /_id/ }],
          %w(created_at updated_at),
          ['id']
        ].flatten.compact.map(&:to_sym)
      end

      def blacklisted?(field_name)
        blacklist.include? field_name.to_sym
      end
    end
  end
end

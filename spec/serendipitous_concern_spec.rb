require 'spec_helper'
require 'rspec/active_model/mocks'
require 'active_model'

class Character
  include ActiveModel::Model
  include ActiveModel::AttributeMethods
  include Serendipitous::Concern

  define_attribute_methods :name, :age, :description, :id, :friend_id, :created_at
  attr_accessor :name, :age, :description, :id, :friend_id, :created_at

  def attributes
    { 'name': @name, 'age': @age, 'description': @description, 'id': @id, 'friend_id': @friend_id, 'created_at': @created_at }
  end

  def self.column_names
    ['name', 'age', 'description', 'id', 'friend_id', 'created_at']
  end
end

RSpec.describe Serendipitous::Concern do
  before(:all) do
    I18n.load_path = Dir['spec/en.yml']
  end

  context 'always' do
    describe '#blacklist and #blacklisted?' do
      it 'contains "id" fields' do
        expect(Character.blacklist).to include(:id)
        expect(Character.blacklisted?(:id)).to be true
      end

      it 'contains "*_id" fields' do
        expect(Character.blacklist).to include(:friend_id)
        expect(Character.blacklisted?(:friend_id)).to be true
      end

      it 'does not contain whitelisted fields' do
        expect(Character.blacklist).to_not include(:name)
        expect(Character.blacklist).to_not include(:age)
        expect(Character.blacklisted?(:name)).to be false
        expect(Character.blacklisted?(:age)).to be false
      end
    end

    describe '#whitelist and #whitelisted?' do
      it 'contains all non-blacklisted fields' do
        expect(Character.whitelist).to include(:name)
        expect(Character.whitelist).to include(:age)
        expect(Character.whitelisted?(:name)).to be true
        expect(Character.whitelisted?(:age)).to be true
      end

      it 'does not contain blacklisted fields' do
        expect(Character.whitelist).to_not include(:id)
        expect(Character.whitelist).to_not include(:friend_id)
        expect(Character.whitelist).to_not include(:created_at)
        expect(Character.whitelisted?(:id)).to be false
        expect(Character.whitelisted?(:friend_id)).to be false
        expect(Character.whitelisted?(:created_at)).to be false
      end
    end
  end

  context 'when a question for an attribute is under the generic underscore' do
    it 'has a question for the field' do
      @model = Character.new(name: 'Character')
      expect(@model.question(:description)[:question]).to eq('Describe Character.')
    end
  end

  context 'when a field is unanswered' do
    before(:each) do
      @model = Character.new(name: 'Character', age: nil)
    end

    it 'asks a question' do
      expect(@model.question(:age)[:question]).to eq('How old is Character?')
    end

    it 'says what field it is asking for' do
      expect(@model.question(:age)[:field]).to eq(:age)
    end

    it 'answers true to unanswered?' do
      expect(@model.unanswered?(:age)).to be true
    end

    it 'puts the unanswered field in the unanswered_fields collection' do
      expect(@model.unanswered_fields).to include(:age)
    end

    it 'puts the unanswered field in the answerable_fields collection' do
      expect(@model.answerable_fields).to include(:age)
    end

    it 'does not include blacklisted fields in the answerable_fields list' do
      expect(@model.unanswered_fields).to_not include(:id)
    end
  end

  context 'when all fields are answered' do
    it 'returns nil' do
      @model = Character.new(name: 'Character', 'age': 25, 'description': 'a character', 'id': 1, 'friend_id': 2, 'created_at': Time.now.to_s )

      expect(@model.question).to be(nil)
    end
  end
end

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
    {
      'name' => @name,
      'age' => @age,
      'description' => @description,
      'id' => @id,
      'friend_id' => @friend_id,
      'created_at' => @created_at
    }
  end

  def self.column_names
    [
      'name',
      'age',
      'description',
      'id',
      'friend_id',
      'created_at'
    ]
  end
end

# Just testing our model to make sure we've created it like an ActiveRecord model
describe Character do
  describe '.attributes.keys' do
    subject { Character.new.attributes.keys }
    it { is_expected.to all(be_a(String)) }
  end

  describe '#column_names' do
    subject { Character.column_names }
    it { is_expected.to all(be_a(String)) }
  end
end

describe Serendipitous::Concern do
  before(:all) do
    I18n.load_path = Dir['spec/en.yml']
  end

  describe '#blacklist' do
    subject { Character.blacklist }
    it { is_expected.to include(:id) }
    it { is_expected.to include(:friend_id) }
    it { is_expected.to include(:created_at) }
    it { is_expected.to_not include(:name) }
    it { is_expected.to_not include(:age) }
  end

  describe '#blacklisted?' do
    it 'is true for id fields' do
      expect(Character.blacklisted?(:id)).to be true
      expect(Character.blacklisted?(:friend_id)).to be true
    end

    it 'is false for non-blacklisted fields' do
      expect(Character.blacklisted?(:name)).to be false
      expect(Character.blacklisted?(:age)).to be false
    end

    it 'accepts strings as arguments' do
      expect(Character.blacklisted?('id')).to be true
      expect(Character.blacklisted?('name')).to be false
    end
  end

  describe '#whitelist' do
    subject { Character.whitelist }
    it { is_expected.to include(:name) }
    it { is_expected.to include(:age) }
    it { is_expected.to_not include(:id) }
    it { is_expected.to_not include(:friend_id) }
    it { is_expected.to_not include(:created_at) }
  end

  describe '#whitelisted?' do
    it 'is true for whitelisted fields' do
      expect(Character.whitelisted?(:name)).to be true
      expect(Character.whitelisted?(:age)).to be true
    end

    it 'accepts strings as arguments' do
      expect(Character.whitelisted?('name')).to be true
      expect(Character.whitelisted?('id')).to be false
    end

    it 'is false for non-whitelisted fields' do
      expect(Character.whitelisted?(:id)).to be false
      expect(Character.whitelisted?(:friend_id)).to be false
      expect(Character.whitelisted?(:created_at)).to be false
    end
  end

  context 'when the question for "description" is in "attributes._"' do
    describe '.question(:description)[:question]' do
      subject { Character.new(name: 'Character').question(:description)[:question] }

      it { is_expected.to eq('Describe Character.') }
    end
  end


  context 'when Character.age is nil' do
    let(:model) { Character.new(name: 'Character', age: nil) }

    describe '.question(:age)[:question]' do
      subject { model.question(:age)[:question] }

      it { is_expected.to eq('How old is Character?') }
    end

    describe '.question(:age)[:field]' do
      subject { model.question(:age)[:field] }

      it { is_expected.to eq(:age) }
    end

    describe '.unanswered?(:age)' do
      subject { model.unanswered?(:age) }
      it { is_expected.to eq(true)}
    end

    describe '.unanswered_fields' do
      subject { model.unanswered_fields }

      it { is_expected.to include(:age) }
      it { is_expected.to_not include(:id) }
    end

    describe '.answerable_fields' do
      subject { model.answerable_fields }
      it { is_expected.to include(:age) }
    end
  end

  context 'when all fields are answered' do
    let(:model) {
      Character.new(
        name: 'Character',
        'age': 25,
        'description': 'a character',
        'id': 1,
        'friend_id': 2,
        'created_at': Time.now.to_s
      )
    }

    describe '.question' do
      subject { model.question }

      it { is_expected.to eq(nil) }
    end
  end
end

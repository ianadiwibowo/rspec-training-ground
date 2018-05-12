require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { is_expected.to have_many(:projects) }
    it { is_expected.to have_many(:notes) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email).case_insensitive }

  end

  describe '#name' do
    it "returns a user's full name as a string" do
      user = build_stubbed(:user, first_name: 'John', last_name: 'Doe')
      expect(user.name).to eq('John Doe')
    end
  end
end

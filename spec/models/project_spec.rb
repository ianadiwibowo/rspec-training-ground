require 'rails_helper'

RSpec.describe Project, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:owner).class_name('User') }
    it { is_expected.to have_many(:notes) }
    it { is_expected.to have_many(:tasks) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:user_id) }
  end

  describe '#late?' do
    let(:project1) { FactoryBot.build(:project, :due_yesterday) }
    let(:project2) { FactoryBot.build(:project, :due_today) }
    let(:project3) { FactoryBot.build(:project, :due_tomorrow) }

    context 'when due date is in the past' do
      it 'returns true' do
        expect(project1).to be_late
      end
    end

    context 'when due date is today' do
      it 'returns false' do
        expect(project2).to_not be_late
      end
    end

    context 'when due date is in the future' do
      it 'returns false' do
        expect(project3).to_not be_late
      end
    end
  end
end

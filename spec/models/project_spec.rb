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
    context 'when due date is in the past' do
      it 'returns true' do
        project1 = build_stubbed(:project, :due_yesterday)
        expect(project1).to be_late
      end
    end

    context 'when due date is today' do
      it 'returns false' do
        project2 = build_stubbed(:project, :due_today)
        expect(project2).to_not be_late
      end
    end

    context 'when due date is in the future' do
      it 'returns false' do
        project3 = build_stubbed(:project, :due_tomorrow)
        expect(project3).to_not be_late
      end
    end
  end
end

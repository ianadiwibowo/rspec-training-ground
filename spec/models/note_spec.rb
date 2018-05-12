require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:message) }
  end

  describe '.search' do
    let(:user) { FactoryBot.create(:user) }
    let(:project) { FactoryBot.create(:project, owner: user) }
    let(:note1) { FactoryBot.create(:note, project: project, message: 'This is the first note') }
    let(:note2) { FactoryBot.create(:note, project: project, message: 'This is the second note') }
    let(:note3) { FactoryBot.create(:note, project: project, message: 'First, preheat the oven') }

    context 'when a match is found' do
      it 'returns notes that match the search term' do
        expect(Note.search('first')).to include(note1, note3)
        expect(Note.search('first')).to_not include(note2)
        expect(Note.search('oven')).to include(note3)
      end
    end

    context 'when no match is found' do
      it 'returns an empty collection' do
        expect(Note.search('message')).to be_empty
      end
    end
  end
end

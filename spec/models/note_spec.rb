require 'rails_helper'

RSpec.describe Note, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:project) }
    it { is_expected.to belong_to(:user) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:message) }
    it { is_expected.to have_attached_file(:attachment) }
  end

  describe '.user_name' do
    it 'delegates name to the user who created it' do
      user = instance_double(User, name: 'Fake User')
      note = Note.new
      allow(note).to receive(:user).and_return(user)
      expect(note.user_name).to eq('Fake User')
    end
  end

  describe '.search' do
    let(:note1) { create(:note, message: 'This is the first note') }
    let(:note2) { create(:note, message: 'This is the second note') }
    let(:note3) { create(:note, message: 'First, preheat the oven') }

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

require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'is invalid without a name' do
    project = Project.new(name: nil)
    project.valid?
    expect(project.errors[:name]).to include("can't be blank")
  end

  it 'can have many notes' do
    project = FactoryBot.create(:project, :with_notes)
    expect(project.notes.length).to eq(5)
  end

  describe 'maintain name uniqueness' do
    before do
      @user = FactoryBot.create(:user)
      @user.projects.create(
        name: 'Test Project'
      )
    end

    context 'when two projects belong to a single user' do
      it 'does not allow duplicate project names' do
        new_project = @user.projects.build(
          name: 'Test Project'
        )

        new_project.valid?
        expect(new_project.errors[:name]).to include('has already been taken')
      end
    end

    context 'when two projects belong to separate users' do
      it 'allows users to share the same project name' do
        other_user = FactoryBot.create(:user)
        other_project = other_user.projects.build(
          name: 'Test Project'
        )

        expect(other_project).to be_valid
      end
    end
  end

  describe 'late status' do
    it 'is late when the due date is past today' do
      project = FactoryBot.create(:project, :due_yesterday)
      expect(project).to be_late
    end

    it 'is on time when the due date is today' do
      project = FactoryBot.create(:project, :due_today)
      expect(project).to_not be_late
    end

    it 'is on time when the due date is in the future' do
      project = FactoryBot.create(:project, :due_tomorrow)
      expect(project).to_not be_late
    end
  end
end

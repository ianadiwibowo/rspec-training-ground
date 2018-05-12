require 'rails_helper'

RSpec.describe Task, type: :model do
  let(:project) { FactoryBot.create(:project) }

  it 'is valid with a project and name' do
    task = Task.new(project: project, name: 'Test task')
    expect(task).to be_valid
  end

  it { is_expected.to belong_to :project }
  it { is_expected.to validate_presence_of :project }
  it { is_expected.to validate_presence_of :name }
end

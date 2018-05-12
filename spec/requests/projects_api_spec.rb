require 'rails_helper'

RSpec.describe 'Projects API', type: :request do
  before do
    @user = FactoryBot.create(:user)
    FactoryBot.create(:project, name: 'Sample Project')
    @project2 = FactoryBot.create(:project, name: 'Second Sample Project', owner: @user)
  end

  it 'loads list of projects' do
    get api_projects_path, params: {
      user_email: @user.email,
      user_token: @user.authentication_token
    }

    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json.length).to eq(1)
  end

  it 'loads a single project' do
    get api_project_path(@project2.id), params: {
      user_email: @user.email,
      user_token: @user.authentication_token
    }

    expect(response).to have_http_status(200)

    json = JSON.parse(response.body)
    expect(json['name']).to eq('Second Sample Project')
  end

  it 'creates a project' do
    project_attributes = FactoryBot.attributes_for(:project)

    expect {
      post api_projects_path, params: {
        user_email: @user.email,
        user_token: @user.authentication_token,
        project: project_attributes
      }
    }.to change(@user.projects, :count).by(1)

    expect(response).to have_http_status(200)
  end
end

require 'rails_helper'

RSpec.describe "Users", type: :request do
  let!(:users) { create_list(:user, 10) }
  let(:user_id) { users.first.id.to_s }

  describe 'GET /users' do
    before { get '/users' }

    it 'returns users' do
      expect(json).not_to be_empty
      expect(json_api.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns sorted results desc' do
      User.all.destroy
      create(:user, name: 1)
      create(:user, name: 2)
      create(:user, name: 3)

      get '/users', params: { sort: '-name' }

      users_ids = json['data'].map { |user| user['attributes']['name'].to_i }

      expect(response).to have_http_status(200)
      expect(users_ids).to eq([3,2,1])
    end
  end
end

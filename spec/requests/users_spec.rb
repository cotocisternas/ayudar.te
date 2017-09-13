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

    it 'returns sorted results asc' do
      User.all.destroy
      create(:user, name: 1)
      create(:user, name: 2)
      create(:user, name: 3)

      get '/users', params: { sort: 'name' }

      users_ids = json['data'].map { |user| user['attributes']['name'].to_i  }

      expect(response).to have_http_status(200)
      expect(users_ids).to eq([1,2,3])
    end

    it 'returns paginated results' do
      create_list(:user, 20)

      get '/users', params: { sort: '-name', page: {number: 2} }

      expect(response).to have_http_status(200)
      expect(json_api.size).to eq(10)
      expect(URI.unescape(json['links']['first'])).to eq('http://www.example.com/users?page[number]=1&page[size]=10&sort=-name')
      expect(URI.unescape(json['links']['prev'])).to eq('http://www.example.com/users?page[number]=1&page[size]=10&sort=-name')
      expect(URI.unescape(json['links']['self'])).to eq('http://www.example.com/users?page[number]=2&page[size]=10&sort=-name')
      expect(URI.unescape(json['links']['next'])).to eq('http://www.example.com/users?page[number]=3&page[size]=10&sort=-name')
      expect(URI.unescape(json['links']['last'])).to eq('http://www.example.com/users?page[number]=3&page[size]=10&sort=-name')
    end
  end

  describe 'GET /users/:id' do
    before { get "/users/#{user_id}" }

    context 'when the record exists' do
      it 'returns the user', focus: :true do
        expect(json).not_to be_empty
        expect(json_api['id']).to eq(user_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:user_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/not found/)
      end
    end
  end

  describe 'POST /users' do
    let(:valid_attributes) { build(:user).attributes }
    let(:json_attributes) { json_api_attributes('users', valid_attributes) }

    context 'when the request is valid' do
      before { post '/users', params: json_attributes }

      it 'creates a user' do
        expect(json_api['attributes']['name']).to eq(valid_attributes['name'])
        expect(response.headers['Location']).to match(/\/users\/\w+$/)
        expect(response.body).to be_json_api_response_for('users')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/users', params: json_api_attributes('users', {}) }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to have_json_api_errors_for('/data/attributes/name')
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /users/:id' do
    let(:valid_attributes) { build(:user).attributes }
    let(:json_attributes) { json_api_attributes('users', valid_attributes) }

    context 'when the record exists' do
      before { put "/users/#{user_id}", params: json_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end

    context 'when the request is invalid' do
      before { put "/users/#{user_id}", params: json_api_attributes('users', {user: nil}) }


      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to have_json_api_errors_for('/data/attributes/user')
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'DELETE /users/:id' do
    before { delete "/users/#{user_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end

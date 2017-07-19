require 'rails_helper'

RSpec.describe 'Venues API', type: :request do
  let!(:venues) { create_list(:venue, 10) }
  let(:venue_id) { venues.first.id.to_s }

  describe 'GET /venues' do
    before { get '/venues' }

    it 'returns venues' do
      expect(json).not_to be_empty
      expect(json_api.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET /venues/:id' do

    before { get "/venues/#{venue_id}" }

    context 'when the record exists' do
      it 'returns the venue', focus: :true do
        expect(json).not_to be_empty
        expect(json_api['id']).to eq(venue_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:venue_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/not_found/)
      end
    end
  end

  describe 'POST /venues' do
    let(:valid_attributes) { attributes_for(:venue) }
    let(:json_attributes) { json_api_attributes('venues', valid_attributes) }

    context 'when the request is valid' do
      before { post '/venues', params: json_attributes }

      it 'creates a venue' do
        expect(json_api['attributes']['name']).to eq(valid_attributes[:name])
        expect(response.headers['Location']).to match(/\/venues\/\w+$/)
        expect(response.body).to be_json_api_response_for('venues')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/venues', params: json_api_attributes('venues', {}) }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

  end

  #
  # describe 'POST /todos' do
  #     # valid payload
  #     let(:valid_attributes) { { title: 'Learn Elm', created_by: '1' } }
  #
  #     context 'when the request is invalid' do
  #       before { post '/todos', params: { title: 'Foobar' } }
  #
  #       it 'returns status code 422' do
  #         expect(response).to have_http_status(422)
  #       end
  #
  #       it 'returns a validation failure message' do
  #         expect(response.body)
  #           .to match(/Validation failed: Created by can't be blank/)
  #       end
  #     end
  #   end
  #
  #   # Test suite for PUT /todos/:id
  #   describe 'PUT /todos/:id' do
  #     let(:valid_attributes) { { title: 'Shopping' } }
  #
  #     context 'when the record exists' do
  #       before { put "/todos/#{todo_id}", params: valid_attributes }
  #
  #       it 'updates the record' do
  #         expect(response.body).to be_empty
  #       end
  #
  #       it 'returns status code 204' do
  #         expect(response).to have_http_status(204)
  #       end
  #     end
  #   end
  #
  #   # Test suite for DELETE /todos/:id
  #   describe 'DELETE /todos/:id' do
  #     before { delete "/todos/#{todo_id}" }
  #
  #     it 'returns status code 204' do
  #       expect(response).to have_http_status(204)
  #     end
  #   end



end

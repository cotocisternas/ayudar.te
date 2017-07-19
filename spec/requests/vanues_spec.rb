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

    it 'returns sorted results' do
      Venue.all.destroy
      create(:venue, name: 1)
      create(:venue, name: 2)
      create(:venue, name: 3)

      get '/venues', params: { sort: '-name' }

      venues_ids = json['data'].map { |venue| venue['attributes']['name'].to_i  }

      expect(response).to have_http_status(200)
      expect(venues_ids).to eq([3,2,1])
    end

    it 'returns paginated results' do
      create_list(:venue, 20)

      get '/venues', params: { sort: '-name', page: {number: 2} }

      expect(response).to have_http_status(200)
      expect(json_api.size).to eq(10)
      expect(URI.unescape(json['links']['first'])).to eq('http://www.example.com/venues?page[number]=1&page[size]=10&sort=-name')
      expect(URI.unescape(json['links']['prev'])).to eq('http://www.example.com/venues?page[number]=1&page[size]=10&sort=-name')
      expect(URI.unescape(json['links']['self'])).to eq('http://www.example.com/venues?page[number]=2&page[size]=10&sort=-name')
      expect(URI.unescape(json['links']['next'])).to eq('http://www.example.com/venues?page[number]=3&page[size]=10&sort=-name')
      expect(URI.unescape(json['links']['last'])).to eq('http://www.example.com/venues?page[number]=3&page[size]=10&sort=-name')
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
        expect(response.body).to match(/not found/)
      end
    end
  end

  describe 'POST /venues' do
    let(:valid_attributes) { build(:venue).attributes }
    let(:json_attributes) { json_api_attributes('venues', valid_attributes) }

    context 'when the request is valid' do
      before { post '/venues', params: json_attributes }

      it 'creates a venue' do
        expect(json_api['attributes']['name']).to eq(valid_attributes['name'])
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

      it 'returns a validation failure message' do
        expect(response.body).to have_json_api_errors_for('/data/attributes/name')
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /venues/:id' do
    let(:valid_attributes) { build(:venue).attributes }
    let(:json_attributes) { json_api_attributes('venues', valid_attributes) }

    context 'when the record exists' do
      before { put "/venues/#{venue_id}", params: json_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /venues/:id' do
    before { delete "/venues/#{venue_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end

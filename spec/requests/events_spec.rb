require 'rails_helper'

RSpec.describe 'Events API', type: :request do
  let!(:events) { create_list(:event, 10) }
  let(:event_id) { events.first.id.to_s }

  describe 'GET /events' do
    before { get '/events' }

    it 'returns events' do
      expect(json).not_to be_empty
      expect(json_api.size).to eq(10)
    end

    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end

    it 'returns sorted results' do
      Event.all.destroy
      create(:event, name: 1)
      create(:event, name: 2)
      create(:event, name: 3)

      get '/events', params: { sort: '-name' }

      events_ids = json['data'].map { |event| event['attributes']['name'].to_i }

      expect(response).to have_http_status(200)
      expect(events_ids).to eq([3,2,1])
    end

    it 'returns paginated results' do
      create_list(:event, 20)

      get '/events', params: { sort: '-name', page: {number: 2} }

      expect(response).to have_http_status(200)
      expect(json_api.size).to eq(10)
      expect(URI.unescape(json['links']['first'])).to eq('http://www.example.com/events?page[number]=1&page[size]=10&sort=-name')
      expect(URI.unescape(json['links']['prev'])).to eq('http://www.example.com/events?page[number]=1&page[size]=10&sort=-name')
      expect(URI.unescape(json['links']['self'])).to eq('http://www.example.com/events?page[number]=2&page[size]=10&sort=-name')
      expect(URI.unescape(json['links']['next'])).to eq('http://www.example.com/events?page[number]=3&page[size]=10&sort=-name')
      expect(URI.unescape(json['links']['last'])).to eq('http://www.example.com/events?page[number]=3&page[size]=10&sort=-name')
    end
  end

  describe 'GET /events/:id' do
    before { get "/events/#{event_id}" }

    context 'when the record exists' do
      it 'returns the event', focus: :true do
        expect(json).not_to be_empty
        expect(json_api['id']).to eq(event_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:event_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/not found/)
      end
    end
  end

  describe 'POST /events' do
    let(:valid_attributes) { build(:event).attributes }
    let(:json_attributes) { json_api_attributes('events', valid_attributes) }

    context 'when the request is valid' do
      before { post '/events', params: json_attributes }

      it 'creates a event' do
        expect(json_api['attributes']['name']).to eq(valid_attributes['name'])
        expect(response.headers['Location']).to match(/\/events\/\w+$/)
        expect(response.body).to be_json_api_response_for('events')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post '/events', params: json_api_attributes('events', {}) }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end

      it 'returns a validation failure message' do
        expect(response.body).to have_json_api_errors_for('/data/attributes/name')
        expect(response.body).to match(/can't be blank/)
      end
    end
  end

  describe 'PUT /events/:id' do
    let(:valid_attributes) { build(:event).attributes }
    let(:json_attributes) { json_api_attributes('events', valid_attributes) }

    context 'when the record exists' do
      before { put "/events/#{event_id}", params: json_attributes }

      it 'updates the record' do
        expect(response.body).to be_empty
      end

      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end

  describe 'DELETE /events/:id' do
    before { delete "/events/#{event_id}" }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

end

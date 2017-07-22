require 'rails_helper'

RSpec.describe 'GridFS API', type: :request do
  let!(:venue) { create(:venue, :photo) }

  describe 'GET /files/*path' do

    context 'when the image exist' do
      before { get venue.image.url }

      it 'returns image' do
        expect(response.body).to eq(venue.image.file.read)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the image does not exist' do
      before { get '/files/foo.bar' }

      it 'returns image' do
        expect(response.body).to be_empty
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(404)
      end
    end

  end
end

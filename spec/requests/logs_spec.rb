require 'rails_helper'

RSpec.describe 'Logs API', :type => :request do
  # create some test data
  let(:user) { create(:user) }
  let!(:work) { create(:work, created_by: user.id) }
  let!(:logs) { create_list(:log, 20, work_id: work.id ) }
  let(:work_id) { work.id }
  let(:id) { logs.first.id }
  let(:headers) { valid_headers }
  
  
  # Test suite for GET /works/:work_id/logs
  # View all logs
  describe 'GET /works/:work_id/logs' do
    before { get "/works/#{work_id}/logs", params: {}, headers: headers  }
    
    context 'when work exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
      
      it 'returns all work logs' do
        expect(json.size).to eq(20)
      end
    end
    
    context 'when work does not exist' do
      let(:work_id) { 0 }
      
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
      
      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Work/)
      end
    end
  end
  
  # Test suite for GET /works/:work_id/logs/:id
  # View a particular log entry
  describe 'GET /works/:work_id/logs/:id' do
    before { get "/works/#{work_id}/logs/#{id}", params: {}, headers: headers  }

    context 'when work log exists' do
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end

      it 'returns the log' do
        expect(json['id']).to eq(id)
      end
    end

    context 'when work log does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Log/)
      end
    end
  end

  # Test suite for POST /works/:work_id/logs
  # Create a new log
  describe 'POST /works/:work_id/logs' do
    let(:valid_attributes) { { note: 'Notice the texture on the surface of this mug.' }.to_json }

    context 'when request attributes are valid' do
      before { post "/works/#{work_id}/logs", params: valid_attributes, headers: headers }

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
  end

  # Test suite for PUT /works/:work_id/logs/:id
  # Update a log entry
  describe 'PUT /works/:work_id/logs/:id' do
    let(:valid_attributes) { { note: 'Amazing' }.to_json }

    before { put "/works/#{work_id}/logs/#{id}", params: valid_attributes, headers: headers }

    context 'when log exists' do
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end

      it 'updates the log' do
        updated_log = Log.find(id)
        expect(updated_log.note).to match(/Amazing/)
      end
    end

    context 'when the log does not exist' do
      let(:id) { 0 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end

      it 'returns a not found message' do
        expect(response.body).to match(/Couldn't find Log/)
      end
    end
  end

  # Test suite for DELETE /works/:work_id/logs/:id
  # Delete a log entry
  describe 'DELETE /works/:work_id/logs/:id' do
    before { delete "/works/#{work_id}/logs/#{id}", params: {}, headers: headers }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end  
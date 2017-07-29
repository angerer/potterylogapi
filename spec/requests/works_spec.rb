require 'rails_helper'
require 'pp'

RSpec.describe 'Works API', :type => :request do
  # create some test data
  let(:user) { create(:user) }
  let!(:works) { create_list(:work, 5, created_by: user.id) }
  let(:work_id) { works.first.id }
  # authorize request
  let(:headers) { valid_headers }
  
  # Test suite for GET / works
  describe 'GET /works' do
    # HTTP GET request
    before { get '/works', params: {}, headers: headers }
    
    it 'returns works' do
      pp headers
      expect(json).not_to be_empty
      expect(json.size).to eq(5)
    end
    
    it 'returns status code 200' do
      expect(response).to have_http_status(200)
    end
  end
  
  # Test suite for GET /works/:id
  describe 'GET /works/:id' do
    before { get "/works/#{work_id}", params: {}, headers: headers }
    
    context 'when the record exists' do
      it 'returns the todo' do
        expect(json).not_to be_empty
        expect(json['id']).to eq(work_id)
      end
    
      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:work_id) { 100 }
    
      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end
  
  # Test suite for POST /works
  describe 'POST /works' do
    # declare a valid request payload
    let(:valid_attributes) do
      pp user
      { project: 'Bronto mugs', status: 'New', created_by: user.id.to_s }.to_json
    end
    
    context 'when the request is valid' do
      before do
        post '/works', params: valid_attributes, headers: headers
      end
      
      it 'creates a work' do
        expect(json['project']).to eq('Bronto mugs')
      end
      
      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end
    
    let(:not_valid_attributes) do
      { project: 'Broken mugs', created_by: user.id.to_s }.to_json
    end
    
    context 'when the request is invalid' do
      before do
        # pp "User: #{user.to_json}"
        # pp "Valid Attrs: #{not_valid_attributes}"
        
        post '/works', params: not_valid_attributes, headers: headers
      end
      
      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
      
      it 'returns a validation falure message' do
        expect(response.body).to match(/Validation failed: Status can't be blank/)
      end
    end
  end
  
  # Test suite for PUT /works/:id
  describe 'PUT /works/:id' do
    let(:valid_attributes) { { project: 'Fancy new vases' }.to_json }
    
    context 'when the record exists' do
      before { put "/works/#{work_id}", params: valid_attributes, headers: headers  }
      
      it 'updates the record' do
        expect(response.body).to be_empty
      end
      
      it 'returns status code 204' do
        expect(response).to have_http_status(204)
      end
    end
  end
  
  # Test suite for DELETE /works/:id
  describe 'DELETE /works/:id' do
    before { delete "/works/#{work_id}", params: {}, headers: headers  }
    
    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end
end

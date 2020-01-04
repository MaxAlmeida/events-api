require 'rails_helper'

RSpec.describe 'Events API', type: :request do
    let!(:events) { create_list(:event, 10)}
    let(:event_id){ events.first.id}

    #Test suite for GET /events
    describe 'GET /events' do
        before { get '/api/v1/events' }

        it 'return events' do
            expect(json).not_to be_empty
            expect(json.size).to eq(10)
        end

        it 'returns status code 200' do
            expect(response).to have_http_status(200)
        end
    end

    describe 'GET /events/:id' do
        before{ get "/api/v1/events/#{event_id}" }

        context 'when the record exists' do
            it 'returns the event' do
                expect(json).not_to be_empty
                expect(json['id']).to eq(event_id)
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
                expect(response.body).to match(//)
            end
        end
    end

    describe 'POST /events' do
        let(:valid_attributes) do 
            { 
              name: 'Show',
              description: 'Beatiful show',
              latitude: 20.00, 
              longitude: 35.00 
            }
        end

        context "when the request is valid" do
            before {post '/api/v1/events', params: valid_attributes}

            it 'creates a event' do
                expect(json['name']).to eq('Show')
            end
    
            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request is invalid' do
            before {post '/api/v1/events', params: { description: "Beautiful show in Las vegas",
                 longitude: 22.22, latitude: 33.10}}

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body)
                    .to match(/Validation failed: Name can't be blank/)
            end
        end
    end

    describe 'PUT /events/:id' do
        let(:valid_attributes) {{ name: "The sunset show in dubai"}}

        context 'when the record exists' do
            before { put "/api/v1/events/#{event_id}", params: valid_attributes}

            it 'updates the record' do
                expect(response.body).to be_empty
            end

            it 'returns status code 204' do
                expect(response).to have_http_status(204)
            end
        end
    end

    describe 'DELETE /events/:id' do
        before { delete "/api/v1/events/#{event_id}"}

        it "returns status code 204" do
            expect(response).to have_http_status(204)
        end
    end
end
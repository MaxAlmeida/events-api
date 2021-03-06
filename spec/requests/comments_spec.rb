require 'rails_helper'

RSpec.describe 'Comments API' do
    let!(:event){ create(:event)}
    let!(:user){create(:user)}
    let!(:comments) { create_list(:comment, 15, event_id: event.id, user_id: user.id)}
    let(:user_id) {user.id}
    let(:event_id) { event.id}
    let(:id) { comments.first.id}

    describe 'GET /events/:event_id/comments' do
        before { get "/api/v1/events/#{event_id}/comments"}

        context 'when event exist' do
            it 'returns status code 200' do
                expect(response).to have_http_status(200)
            end

            it 'returns all event comments' do
                expect(json.size).to eq(15)
            end
        end

        context 'when event does not exist' do
            let(:event_id) { 0 }
      
            it 'returns status code 404' do
              expect(response).to have_http_status(404)
            end
      
            it 'returns a not found message' do
              expect(response.body).to match(/Couldn't find Event/)
            end
        end
    end

    describe 'GET /events/:event_id/reports' do

      context 'when event has comments reported' do
        let!(:report) {create(:report, user_id: user_id, comment_id: id)}
        before { get "/api/v1/events/#{event_id}/reports"}

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'return event reported comments' do
          expect(json.size).to eq(1)
        end
      end

      context 'when event has not comments reported' do
        before { get "/api/v1/events/#{event_id}/reports"}

        it 'returns status code 200' do
          expect(response).to have_http_status(200)
        end

        it 'return event reported comments' do
          expect(json.size).to eq(0)
        end
      end
    end

    describe "GET /events/:event_id/comments/:id" do
        before { get "/api/v1/events/#{event_id}/comments/#{id}" }

        context 'when event comment exists' do
            it 'returns status code 200' do
              expect(response).to have_http_status(200)
            end
      
            it 'returns the comment' do
              expect(json['id']).to eq(id)
            end
        end

        context 'when event comment does not exist' do
            let(:id) { 0 }
      
            it 'returns status code 404' do
              expect(response).to have_http_status(404)
            end
      
            it 'returns a not found message' do
              expect(response.body).to match(/Couldn't find Comment/)
            end
        end
    end

    describe 'POST /events/:event_id/comments' do
        let(:valid_attributes) { { text: "Nice event, i loved it", user_id: user_id } }
    
        context 'when request attributes are valid' do
          before { post "/api/v1/events/#{event_id}/comments", params: valid_attributes }

          it 'returns comment' do
            expect(json['text']).to eq('Nice event, i loved it')
          end
          it 'returns status code 201' do
            expect(response).to have_http_status(201)
          end
        end
    
        context 'when an invalid request' do
          before { post "/api/v1/events/#{event_id}/comments", params: {} }
    
          it 'returns status code 422' do
            expect(response).to have_http_status(422)
          end
    
          it 'returns a failure message' do
            expect(response.body).to match(/Validation failed: User must exist, Text can't be blank/)
          end
        end
    end

    describe 'PUT /events/:event_id/comments/:id' do
        let(:valid_attributes) { { text: 'Beutiful event, i loved it!' } }
    
        before { put "/api/v1/events/#{event_id}/comments/#{id}", params: valid_attributes }
    
        context 'when comment exists' do
          it 'returns status code 204' do
            expect(response).to have_http_status(204)
          end
    
          it 'updates the comment' do
            updated_comment = Comment.find(id)
            expect(updated_comment.text).to match(/Beutiful event, i loved it!/)
          end
        end
    
        context 'when the comment does not exist' do
          let(:id) { 0 }

          it 'returns status code 404' do
            expect(response).to have_http_status(404)
          end
    
          it 'returns a not found message' do
            expect(response.body).to match(/Couldn't find Comment/)
          end
        end
    end

    describe 'DELETE /event/:id/comments/:id' do
      
        before { delete "/api/v1/events/#{event_id}/comments/#{id}" }
    
        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
    end
end
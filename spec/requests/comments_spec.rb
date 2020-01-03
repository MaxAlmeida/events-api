require 'rails_helper'

RSpec.describe 'Comments API' do
    let!(:event){ create(:event)}
    let!(:user){create(:user)}
    let!(:comments) { create_list(:comment, 15, event_id: event.id, user_id: user.id)}
    let(:user_id) {user.id}
    let(:event_id) { event.id}
    let(:id) { comments.first.id}

    describe 'GET /events/:event_id/comments' do
        before { get "/events/#{event_id}/comments"}

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

    describe "GET /events/:event_id/comments/:id" do
        before { get "/events/#{event_id}/comments/#{id}" }

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
          before { post "/events/#{event_id}/comments", params: valid_attributes }
    
          it 'returns status code 201' do
            expect(response).to have_http_status(201)
          end
        end
    
        context 'when an invalid request' do
          before { post "/events/#{event_id}/comments", params: {} }
    
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
    
        before { put "/events/#{event_id}/comments/#{id}", params: valid_attributes }
    
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
      
        before { delete "/events/#{event_id}/comments/#{id}" }
    
        it 'returns status code 204' do
          expect(response).to have_http_status(204)
        end
    end
end
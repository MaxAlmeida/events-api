require 'rails_helper'

RSpec.describe 'Comments API' do
    let!(:user){create(:user)}
    let!(:event){create(:event)}
    let!(:comment) { create(:comment, event_id: event.id, user_id: user.id)}
    let(:user_id) {user.id}
    let(:comment_id){ comment.id }

    describe 'POST reports' do
    
        context 'when the request is valid' do
            before { post '/api/v1/reports', params: {user_id: user_id, comment_id: comment_id} }

            it 'create reports' do
                expect(json['comment_id']).to eq(comment_id)
            end

            it 'returns status code 201' do
                expect(response).to have_http_status(201)
            end
        end

        context 'when the request without params' do
            before { post '/api/v1/reports', params: {}}

            it 'returns status code 404' do
                expect(response).to have_http_status(404)
            end

            it 'returns a validation failure message' do
                expect(response.body)
                    .to match(/Couldn't find Comment without an ID/)
            end
        end

        context 'when the request without user_id' do
            before { post '/api/v1/reports', params: {comment_id: comment_id}}

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body)
                    .to match(/Validation failed: User must exist/)
            end
        end

        context 'when request more than once report to same comment' do
            before do 
                post '/api/v1/reports', params: {user_id: user_id, comment_id: comment_id}
                post '/api/v1/reports', params: {user_id: user_id, comment_id: comment_id}
            end

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body)
                    .to match(/Validation failed: User has already been taken/)
            end
        end
    end
end
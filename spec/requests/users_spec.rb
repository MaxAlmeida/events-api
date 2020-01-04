require 'rails_helper'

RSpec.describe 'Users API' do
    describe 'POST /signup'do
        let(:user) { build(:user) }

        context 'When the request is valid' do
            let(:valid_attributes) do 
                { 
                  name: user.name,
                  email: user.email,
                  password: '123', 
                  password_confirmation: '123' 
                }
            end

            before { post '/api/v1/signup', params: valid_attributes }
            
            it "create a user" do
                expect(json['user']['name']).to eq(user.name)
            end

            it "returns status code 201" do
                expect(response).to have_http_status(201)
            end
        end

        context "when the request is without name" do
            let(:invalid_attributes) do 
                { 
                  email: user.email,
                  password: '123', 
                  password_confirmation: '123' 
                }
            end

            before { post '/api/v1/signup', params: invalid_attributes }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body)
                    .to match(/Validation failed: Name can't be blank/)
            end

        end

        context "when the request is with differente email" do
            let(:invalid_attributes) do 
                { 
                  name: user.name,
                  email: user.email,
                  password: '123', 
                  password_confirmation: '012' 
                }
            end

            before { post '/api/v1/signup', params: invalid_attributes }

            it 'returns status code 422' do
                expect(response).to have_http_status(422)
            end

            it 'returns a validation failure message' do
                expect(response.body)
                    .to match(/Password confirmation doesn't match Password/)
            end
        end
    end
end
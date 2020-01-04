module Api
    module V1
        class UsersController < ApplicationController
          def create
              user = User.create!(user_params)
              response = { message: "User successfully created", user: user}
              json_response(response, :created)
          end
          
            private
          
            def user_params
              params.permit(
                :name,
                :email,
                :password,
                :password_confirmation
              )
            end
        end
    end
end

module Api
  module V1
    module Auth
      class SessionsController < ApplicationController
        def create
          user = User.find_by(email: params[:email])
          
          if user&.valid_password?(params[:password])
            sign_in user
            render json: {
              status: 'success',
              message: 'Logged in successfully',
              data: {
                user: {
                  id: user.id,
                  email: user.email,
                  first_name: user.first_name,
                  last_name: user.last_name
                }
              }
            }
          else
            render json: {
              status: 'error',
              message: 'Invalid email or password'
            }, status: :unauthorized
          end
        end

        def destroy
          if current_user
            sign_out current_user
            render json: {
              status: 'success',
              message: 'Logged out successfully'
            }
          else
            render json: {
              status: 'error',
              message: 'No user logged in'
            }, status: :unauthorized
          end
        end
      end
    end
  end
end

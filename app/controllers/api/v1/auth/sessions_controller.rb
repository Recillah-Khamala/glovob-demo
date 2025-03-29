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

        def check_user
          user = User.find_by(email: params[:email])
          render json: { exists: user.present? }
        rescue => e
          render json: { error: e.message }, status: :internal_server_error
        end
      end
    end
  end
end

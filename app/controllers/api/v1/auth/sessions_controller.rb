module Api
  module V1
    module Auth
      class SessionsController < ApplicationController
        def create
          # Extract email and password from the nested structure
          email = params.dig(:user, :email) || params.dig(:session, :user, :email)
          password = params.dig(:user, :password) || params.dig(:session, :user, :password)
          
          user = User.find_by(email: email)
          
          if user&.valid_password?(password)
            # Use warden to sign in the user
            warden.set_user(user)
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
            warden.logout
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
          email = params[:email] || params.dig(:session, :email)
          user = User.find_by(email: email)
          render json: { exists: user.present? }
        rescue => e
          render json: { error: e.message }, status: :internal_server_error
        end
      end
    end
  end
end

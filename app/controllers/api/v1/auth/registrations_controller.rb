module Api
  module V1
    module Auth
      class RegistrationsController < ApplicationController
        def create
          user = User.new(user_params)
          
          if user.save
            render json: {
              status: 'success',
              message: 'User registered successfully',
              data: {
                user: {
                  id: user.id,
                  email: user.email,
                  first_name: user.first_name,
                  last_name: user.last_name
                }
              }
            }, status: :created
          else
            Rails.logger.error "User registration failed: #{user.errors.full_messages}"
            Rails.logger.error "Parameters received: #{user_params.inspect}"
            
            render json: {
              status: 'error',
              message: 'User registration failed',
              errors: user.errors.full_messages
            }, status: :unprocessable_entity
          end
        end

        private

        def user_params
          params.require(:user).permit(:email, :password, :password_confirmation)
        end
      end
    end
  end
end

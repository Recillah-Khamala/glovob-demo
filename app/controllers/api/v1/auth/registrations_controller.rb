module Api
  module V1
    module Auth
      class RegistrationsController < ApplicationController
        def create
          # Use a transaction to ensure atomicity
          User.transaction do
            # Check if user exists again (in case of race condition)
            if User.exists?(email: user_params[:email])
              render json: {
                status: 'error',
                message: 'Email is already registered',
                errors: ['Email is already registered']
              }, status: :unprocessable_entity
              return
            end

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
        end

        private

        def user_params
          params.require(:user).permit(:email, :password, :password_confirmation, :registration_step)
        end
      end
    end
  end
end

module Api
  module V1
    class UserProfilesController < ApplicationController
      before_action :authenticate_user!

      def show
        render json: {
          status: 'success',
          data: {
            user: {
              id: current_user.id,
              email: current_user.email,
              first_name: current_user.first_name,
              last_name: current_user.last_name,
              created_at: current_user.created_at,
              updated_at: current_user.updated_at
            }
          }
        }
      end

      def update
        if current_user.update(user_params)
          render json: {
            status: 'success',
            message: 'Profile updated successfully',
            data: {
              user: {
                id: current_user.id,
                email: current_user.email,
                first_name: current_user.first_name,
                last_name: current_user.last_name,
                updated_at: current_user.updated_at
              }
            }
          }
        else
          render json: {
            status: 'error',
            message: 'Profile update failed',
            errors: current_user.errors.full_messages
          }, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(:first_name, :last_name, :email)
      end
    end
  end
end

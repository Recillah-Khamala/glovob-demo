class UsersController < ApplicationController
  before_action :set_user, only: [:orders]

  # GET /users/:id/orders
  def orders
    @orders = @user.orders.order(created_at: :desc)
    render json: @orders, status: :ok
  end

  private

  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'User not found' }, status: :not_found
  end
end


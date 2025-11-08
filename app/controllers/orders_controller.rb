class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :update_status]

  # POST /orders
  def create
    @order = Order.new(order_params)
    
    if @order.save
      render json: @order, status: :created
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /orders/:id
  def show
    render json: @order, status: :ok
  end

  # PATCH /orders/:id/status
  def update_status
    unless Order.statuses.key?(params[:status])
      return render json: { errors: ["'#{params[:status]}' is not a valid status"] }, status: :unprocessable_entity
    end

    if @order.update(status: params[:status])
      render json: @order, status: :ok
    else
      render json: { errors: @order.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def set_order
    @order = Order.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Order not found' }, status: :not_found
  end

  def order_params
    params.require(:order).permit(:user_id, :office_id, :package_description, :weight,
                                  :delivery_address, :estimated_cost, :estimated_time)
  end
end


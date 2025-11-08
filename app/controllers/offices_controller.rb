class OfficesController < ApplicationController
  before_action :set_office, only: [:show]

  # GET /offices
  def index
    @offices = Office.all
    render json: @offices, status: :ok
  end

  # GET /offices/:id
  def show
    render json: @office, status: :ok
  end

  private

  def set_office
    @office = Office.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Office not found' }, status: :not_found
  end
end


module Api
  module V1
    class OfficesController < BaseController
      before_action :set_office, only: [:show]

      # GET /api/v1/offices
      def index
        @offices = Office.all
        render json: @offices, status: :ok
      end

      # GET /api/v1/offices/:id
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
  end
end


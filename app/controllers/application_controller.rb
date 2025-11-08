class ApplicationController < ActionController::API
  # Handle record not found errors
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  # Handle parameter missing errors
  rescue_from ActionController::ParameterMissing, with: :parameter_missing

  private

  def record_not_found(exception)
    render json: { error: "#{exception.model} not found" }, status: :not_found
  end

  def parameter_missing(exception)
    render json: { error: "Missing parameter: #{exception.param}" }, status: :bad_request
  end
end

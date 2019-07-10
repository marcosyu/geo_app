class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response

  def record_not_found_response
    render json: { message: "Not found", code: "not_found" }, status: :not_found
  end

end

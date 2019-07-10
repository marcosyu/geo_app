module Api::V1

  class BaseController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :record_not_found_response

    def record_not_found_response
      render json: { message: "Not found", code: "not_found" }, status: :not_found
    end
  end

end

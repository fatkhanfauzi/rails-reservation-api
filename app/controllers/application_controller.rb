class ApplicationController < ActionController::API

  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found
  rescue_from ActiveRecord::RecordNotUnique, :with => :record_conflict
  rescue_from ActionController::ParameterMissing, :with => :record_invalid
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  ################
  ## PRIVATE !! ##
  ################

  private

  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def record_conflict(_exception)
    head :conflict
  end

  def record_invalid(exception)
    render json: { error: exception.message }, status: :unprocessable_entity
  end
end

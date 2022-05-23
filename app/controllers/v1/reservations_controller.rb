class V1::ReservationsController < ApplicationController
  include ReservationsHelper

  before_action :set_reservation, only: [:show, :update, :destroy]
  before_action :set_reservations, only: [:index]

  def index
  end

  def show
  end

  def create
    @reservation = ReservationService.new(reservation_params)
      .perform_create
    return render json: @reservation.errors, status: :bad_request if @reservation.errors.any?

    render 'v1/reservations/show', status: :created
  end

  def update
    @reservation = ReservationService.new(reservation_params)
      .perform_update(@reservation)
    return render json: @reservation.errors, status: :bad_request if @reservation.errors.any?

    render 'v1/reservations/show', status: :ok
  end

  def destroy
    @reservation.destroy
    head :no_content
  end

  ################
  ## PRIVATE !! ##
  ################

  private

  def reservation_params
    normalize_params(params)
  end

  def set_reservation
    @reservation = Reservation.find_by_uuid!(params[:uuid])
  end

  def set_reservations
    @reservations = Reservation.all
  end
end

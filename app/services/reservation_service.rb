class ReservationService
  def initialize(params)
    @params = params
  end

  def perform_create
    Reservation.transaction do
      check_guest
      @reservation = Reservation.create(@params)
      raise ActiveRecord::Rollback unless @reservation.persisted? && !@reservation.errors.any?
    end
    return @reservation
  end

  def perform_update(reservation)
    @reservation = reservation
    Reservation.transaction do
      check_guest
      @reservation.update(@params)
      raise ActiveRecord::Rollback unless @reservation.persisted? && !@reservation.errors.any?
    end
    return @reservation
  end

  ################
  ## PRIVATE !! ##
  ################

  private

  ##
  # This method is used to set id required by nested attribute if guest email exists.
  #
  def check_guest
    if @params[:guest_attributes].present?
      @params[:guest_attributes][:id] = Guest.find_by(email: @params[:guest_attributes][:email])&.id
    end
  end
end

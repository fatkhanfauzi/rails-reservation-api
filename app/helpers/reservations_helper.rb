module ReservationsHelper
  NORMAL_PARAMS = [
    :reservation_code, :start_date, :end_date, :nights, :guests, :adults,
    :children, :infants, :status, :currency, :payout_price, :security_price,
    :total_price, guest_attributes: [:first_name, :last_name, :phone, :email]
  ]

  ##
  # The mapper can be extended (in the future for payload type 3) by adding an array item to the value.
  # In this case the left is payload type 1, right is payload type 2.
  #
  PARAMS_MAPPER = {
    reservation_code: [:reservation_code, [:reservation, :code]],
    start_date: [:start_date, [:reservation, :start_date]],
    end_date: [:end_date, [:reservation, :end_date]],
    nights: [:nights, [:reservation, :nights]],
    guests: [:guest, [:reservation, :guest_details, :localized_description]],
    adults: [:adults, [:reservation, :guest_details, :number_of_adults]],
    children: [:children, [:reservation, :guest_details, :number_of_children]],
    infants: [:infants, [:reservation, :guest_details, :number_of_infants]],
    status: [:status, [:reservation, :status_type]],
    currency: [:currency, [:reservation, :host_currency]],
    payout_price: [:payout_price, [:reservation, :expected_payout_amount]],
    security_price: [:security_price, [:reservation, :listing_security_price_accurate]],
    total_price: [:total_price, [:reservation, :total_paid_amount_accurate]],
    guest: {
      first_name: [[:guest, :first_name], [:reservation, :guest_first_name]],
      last_name: [[:guest, :last_name], [:reservation, :guest_last_name]],
      phone: [[:guest, :phone], [:reservation, :guest_phone_numbers, :join_unique_string]],
      email: [[:guest, :email], [:reservation, :guest_email]],
    }
  }

  ##
  # This method is used to normalize the params.
  #
  def normalize_params(params)
    resolve_params_mapping(PARAMS_MAPPER)
    params[:guest_attributes] = params[:guest]
    params.permit(NORMAL_PARAMS)
  end

  ################
  ## PRIVATE !! ##
  ################

  private

  ##
  # This method is used to recursively map the params based on mapper.
  #
  def resolve_params_mapping(mapper, parent_key = nil)
    mapper.each do |key, value|
      if value.is_a?(Hash)
        resolve_params_mapping(value, key)
        next
      end

      value.each do |x|
        res = params.try_chain(*x)
        if res.present?
          if parent_key.present?
            params[parent_key] ||= {}
            params[parent_key][key] = res
          else
            params[key] = res
          end
          break;
        end
      end
    end
  end
end


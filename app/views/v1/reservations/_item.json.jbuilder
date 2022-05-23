json.type "reservation"
json.id(item.id)
json.attributes(item, :uuid, :reservation_code, :start_date, :end_date, :nights,
  :guests, :adults, :children, :infants, :status, :currency, :payout_price,
  :security_price, :total_price)

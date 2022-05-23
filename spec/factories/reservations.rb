FactoryBot.define do
  factory :reservation do
    sequence(:uuid) { |n| "uuid_#{n}" }
    sequence(:reservation_code) { |n| "reservation_code_#{n}" }
    start_date { "2022-05-05" }
    end_date { "2022-05-06" }
    nights { 1 }
    guests { 4 }
    adults { 2 }
    infants { 0 }
    status { "accepted" }
    currency { "AUD" }
    payout_price { 4200.00 }
    security_price { 500.00 }
    total_price { 4700.00 }
    guest
  end
end

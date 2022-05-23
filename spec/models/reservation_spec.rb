require 'rails_helper'

RSpec.describe Reservation, type: :model do

  describe "design definition" do
    %i[id uuid reservation_code start_date end_date nights guests adults children
      infants status currency payout_price security_price total_price guest_id
      created_at updated_at].each do |column|
      it { should have_db_column(column) }
    end
  end

  describe "relationships" do
    it { should belong_to(:guest) }
  end

  describe "validations" do
    describe "presence validations" do
      it { should validate_presence_of(:reservation_code) }
      it { should validate_uniqueness_of(:reservation_code) }
    end
  end
end

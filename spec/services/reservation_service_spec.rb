require_relative '../../app/services/reservation_service'
require 'rails_helper'

RSpec.describe ReservationService do
  let(:instance) { ReservationService.new(normalized_params) }
  let(:normalized_params) do
    {
      "reservation_code": "YYY124522221",
      "start_date": "2021-04-14",
      "end_date": "2021-04-18",
      "nights": 4,
      "guests": 4,
      "adults": 2,
      "children": 2,
      "infants": 0,
      "status": "accepted",
      "guest_attributes": {
        "first_name": "Wayne",
        "last_name": "Woodbridge",
        "phone": "639123456789",
        "email": "wayne_woodbridge@bnb.com"
      },
      "currency": "AUD",
      "payout_price": "4200.00",
      "security_price": "500",
      "total_price": "4700.00"
    }
  end
  let(:reservation) { create :reservation }

  describe "instance methods" do
    describe "perform_create" do
      subject { instance.perform_create }

      it { expect{subject}.to change{Reservation.count}.by(1) }

      context "when reservation_code exists" do
        before { instance.perform_create }

        it { expect{subject}.to change{Reservation.count}.by(0) }
        it { expect(subject.errors.count).to eq(1) }
        it { expect(subject.errors.messages).to eq(:reservation_code=>["has already been taken"]) }
      end
    end

    describe "perform_update" do
      subject { instance.perform_update(reservation) }

      let(:instance) { ReservationService.new(normalized_update_params) }
      let(:normalized_update_params) do
        normalized_params.merge("nights" => 999)
      end

      it { expect{subject}.to change{Reservation.find(reservation.id).nights}.to(999) }

      context "when reservation_code exists" do
        before { create :reservation, reservation_code: normalized_params[:reservation_code] }

        it { expect(subject.errors.count).to eq(1) }
        it { expect(subject.errors.messages).to eq(:reservation_code=>["has already been taken"]) }
      end
    end

    describe "check_guest" do
      subject { instance.send(:check_guest) }

      context "when guest_attributes exists" do
        it do
          expect(Guest).to receive(:find_by)
          subject
        end
      end
    end
  end
end

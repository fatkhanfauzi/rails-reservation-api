require 'rails_helper'

RSpec.describe V1::ReservationsController, type: :controller do
  render_views

  let(:reservation) { create :reservation }
  let(:reservations) { create_list :reservation, 3 }
  let(:payload_1) do
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
      "guest": {
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
  let(:payload_2) do
    {
      "reservation": {
        "code": "XXX12345678",
        "start_date": "2021-03-12",
        "end_date": "2021-03-16",
        "expected_payout_amount": "3800.00",
        "guest_details": {
          "localized_description": "4 guests",
          "number_of_adults": 2,
          "number_of_children": 2,
          "number_of_infants": 0
        },
        "guest_email": "wayne_woodbridge@bnb.com",
        "guest_first_name": "Wayne",
        "guest_last_name": "Woodbridge",
        "guest_phone_numbers": [
          "639123456789",
          "639123456789"
        ],
        "listing_security_price_accurate": "500.00",
        "host_currency": "AUD",
        "nights": 4,
        "number_of_guests": 4,
        "status_type": "accepted",
        "total_paid_amount_accurate": "4300.00"
      }
    }
  end

  describe "GET #index" do
    subject { get :index }

    before { reservations }

    it { is_expected.to have_http_status(:ok) }

    it "returns reservations" do
      subject
      expect(assigns(:reservations)).to match_array(reservations)
    end
  end

  describe "GET #show" do
    subject { get :show, params: { uuid: reservation.uuid } }

    it { is_expected.to have_http_status(:ok) }

    it { is_expected.to render_template(:show) }

    it "returns reservation" do
      subject
      expect(assigns(:reservation)).to eq(reservation)
    end
  end

  describe 'POST #create' do
    subject { post :create, params: params }

    context "with payload 1" do
      let(:params) { payload_1 }

      it { is_expected.to have_http_status(:created) }

      it { is_expected.to render_template(:show) }

      it { expect { subject }.to change { Reservation.count }.by(1) }

      context "when reservation_code exists" do
        before { create :reservation, reservation_code: payload_1[:reservation_code] }

        it { expect { subject }.to change { Reservation.count }.by(0) }

        it "returns error message" do
          subject
          expect(JSON(response.body, symbolize_names: true))
            .to eq({:reservation_code=>["has already been taken"]})
        end
      end
    end

    context "with payload 2" do
      let(:params) { payload_2 }

      it { is_expected.to have_http_status(:created) }

      it { is_expected.to render_template(:show) }

      it { expect { subject }.to change { Reservation.count }.by(1) }

      context "when reservation_code exists" do
        before { create :reservation, reservation_code: payload_2[:reservation][:code] }

        it { expect { subject }.to change { Reservation.count }.by(0) }

        it "returns error message" do
          subject
          expect(JSON(response.body, symbolize_names: true))
            .to eq({:reservation_code=>["has already been taken"]})
        end
      end
    end
  end

  describe "PUT #update" do
    subject { post :update, params: params }

    let(:params) { { uuid: reservation.uuid, reservation: payload_1 } }
    let(:reservation) { create :reservation, reservation_code: payload_1[:reservation_code] }

    before { reservation }

    it { is_expected.to have_http_status(:ok) }

    it { is_expected.to render_template(:show) }

    it { expect{subject}.to change { Reservation.find(reservation.id).nights } }

    context "when reservation doesn't exist" do
      let(:params) { { uuid: "missing_uuid", reservation: payload_1 } }

      it "returns error message" do
        subject
        expect(JSON(response.body, symbolize_names: true))
          .to eq({:error => "Couldn't find Reservation"})
      end
    end
  end

  describe "DELETE #destroy" do
    subject { delete :destroy, params: { uuid: reservation.uuid } }

    it { expect { subject }.to change { Reservation.count }.by(0) }

    it { is_expected.to have_http_status(:no_content) }
  end
end

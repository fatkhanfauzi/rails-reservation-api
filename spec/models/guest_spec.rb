require 'rails_helper'

RSpec.describe Guest, type: :model do

  describe "design definition" do
    %i[id uuid first_name last_name phone email created_at updated_at].each do |column|
      it { should have_db_column(column) }
    end
  end

  describe "relationships" do
    it { should have_many(:reservation) }
  end

  describe "validations" do
    describe "presence validations" do
      it { should validate_presence_of(:email) }
      it { should validate_uniqueness_of(:email) }
    end
  end
end

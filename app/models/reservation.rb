class Reservation < ApplicationRecord
  include Identifiable

  enum status: { accepted: 0, rejected: 1 }, _suffix: true # the default value is 0

  ###################
  ## RELATIONSHIPS ##
  ###################

  belongs_to :guest

  #################
  ## VALIDATIONS ##
  #################

  validates :reservation_code, presence: true, uniqueness: true

  #######################
  ## NESTED ATTRIBUTES ##
  #######################

  accepts_nested_attributes_for :guest

  def guest_attributes=(attributes)
    if attributes[:id].present?
      self.guest = Guest.find(attributes[:id])
    end
    super
  end
end

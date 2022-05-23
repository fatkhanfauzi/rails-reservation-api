class Guest < ApplicationRecord
  include Identifiable

  ###################
  ## RELATIONSHIPS ##
  ###################

  has_many :reservation

  #################
  ## VALIDATIONS ##
  #################

  validates :email, presence: true, uniqueness: :true
end

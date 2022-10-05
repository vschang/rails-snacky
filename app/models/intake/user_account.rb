require 'carrierwave/orm/activerecord'

module Intake
  class UserAccount
    include ActiveModel::Model
    attr_accessor :email, :password

    # mount_uploader :prof_pic, ProfPicUploader
    validates :email, presence: true, format: { with: /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i,
    message: "is invalid" }
    validates :password, presence: true, length: { minimum: 6 }, confirmation: true
    validates :password_confirmation, presence: true
    # validates_confirmation_of :password
  end

  # devise :validatable
end

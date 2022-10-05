require 'carrierwave/orm/activerecord'

module Intake
  class UserPic
    include ActiveModel::Model
    attr_accessor :prof_pic, :username

    validates :prof_pic, presence: true
    validates :username, presence: true
  end
end

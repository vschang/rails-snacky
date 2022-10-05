module Intake
  class UserProfilesController < ApplicationController
    skip_before_action :authenticate_user!

    def new
      if session[:user_profile]
        @first_name = session[:user_profile]["first_name"]
        @last_name = session[:user_profile]["last_name"]
      end
      @user_profile = UserProfile.new
    end

    def create
      @user_profile = UserProfile.new(user_profile_params)
      session[:user_profile] = {
        'first_name' => @user_profile.first_name,
        'last_name' => @user_profile.last_name
      }
      if @user_profile.valid?
        redirect_to new_intake_user_account_path
      else
        flash[:notice] = @user_profile.errors.full_messages[0]
        redirect_to new_intake_user_profile_path
      end
    end

    private

    def user_profile_params
      params.require(:intake_user_profile).permit(
        :first_name,
        :last_name
      )
    end
  end
end

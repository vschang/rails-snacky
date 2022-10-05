module Intake
  class UserAccountsController < ApplicationController
    skip_before_action :authenticate_user!

    def new
      if session[:user_account]
        @email = session[:user_account]["email"]
        @password = session[:user_account]["password"]
      end
      @user_account = UserAccount.new
    end

    def create
      @user_account = UserAccount.new(user_account_params)
      if @user_account.valid?
        session[:user_account] = {
          'email' => @user_account.email,
          'password' => @user_account.password
        }
        redirect_to new_intake_user_pic_path
      else
        flash[:notice] = @user_account.errors.full_messages[0]
        redirect_to new_intake_user_account_path
      end
    end

    private

    def user_account_params
      params.require(:intake_user_account).permit(
        :email,
        :password,
        :password_confirmation
      )
    end
  end
end

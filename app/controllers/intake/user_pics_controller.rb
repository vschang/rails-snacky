module Intake
  class UserPicsController < ApplicationController
    skip_before_action :authenticate_user!

    def new
      if session[:user_pic]
        @username = session[:user_pic]["username"]
        @prof_pic = session[:user_pic]["prof_pic"]
      end

      @user_pic = UserPic.new
    end

    def create
      @user_pic = UserPic.new(user_pic_params)
      if @user_pic.valid?
        # The values from the previous form step need to be
        # retrieved from the session store.
        full_params = user_pic_params.merge(
          first_name: session['user_profile']['first_name'],
          last_name: session['user_profile']['last_name'],
          email: session['user_account']['email'],
          password: session['user_account']['password']
        )

        # creating a User record in the database.
        @user = User.new(full_params)
        if params["intake_user_pic"]["prof_pic"]
          @user.prof_pic.attach(io: params["intake_user_pic"]["prof_pic"].tempfile, filename: params["intake_user_pic"]["prof_pic"].original_filename)
          temp_file.rewind
        end

        if @user.save
          # Upon successful completion of the form we need to clean up the session.
          session.delete('user_profile')
          sign_out_all_scopes
          sign_in(@user)
          redirect_to profile_path
        else
          flash[:notice] = @user.errors.full_messages[0]
          redirect_to new_intake_user_pic_path
        end

      else
        flash[:notice] = @user_pic.errors.full_messages[0]
        redirect_to new_intake_user_pic_path
      end
    end

    private

    def user_pic_params
      params.require(:intake_user_pic).permit(
        :prof_pic,
        :username
      )
    end
  end
end

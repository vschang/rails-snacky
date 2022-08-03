class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @current_user = current_user
    @posts = @user.posts.all.order('created_at DESC')
    @markers = @posts.map do |post|
      {
        lat: post.latitude,
        lng: post.longitude,
        info_window: render_to_string(partial: "posts/info_window", locals: {post: post}),
        image_url: helpers.asset_url("pink-gummy-removebg-preview.png")
      }
    end
  end

  def edit

  end

  def user_params
    params.require(:user).permit(:user_id, :name, :email, :password, :password_confirmation, :prof_pic)
  end
end

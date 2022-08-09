class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :home, :faq, :search ]

  def home
  end

  def faq
  end

  def search
    @posts = Post.all
    if params[:query].present?
      @posts = @posts.global_search(params[:query])
    else
      @posts = []
    end
    @user = current_user

  end

  def profile
    @user = current_user
    @posts = @user.posts
    @total = @posts.all.count
    @geocoded_posts = @posts.geocoded
    @markers = @posts.map do |post|
      {
        lat: post.latitude,
        lng: post.longitude,
        info_window: render_to_string(partial: "posts/info_window", locals: {post: post}),
        image_url: helpers.asset_url("pink-gummy-removebg-preview.png")
      }
    end
  end

  def edit_prof_pic
    @user = current_user
  end

  def update_prof_pic
    @user = current_user
    if params[:user]
      current_user.prof_pic.attach(io: params[:user]["image"].tempfile, filename: params[:user]["image"].original_filename)
      if current_user.save!
        flash[:notice] = "Profile picture updated"
        redirect_to profile_path
      else

        flash[:alert] = "Error uploading file"
        redirect_to edit_prof_pic_path
      end
    end
  end

  def destroy_sesh
    sign_out_and_redirect(current_user)
  end
end

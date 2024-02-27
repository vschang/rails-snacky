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
      @posts = @posts.sort_by {|posts| posts.created_at}.reverse
    else
      @posts = []
    end
    @user = current_user

  end

  def profile
    @user = current_user
    # posts need to be ordered in reverse order
    # @posts = [] if @posts.nil?

    @posts = @user.posts.sort_by {|posts| posts.created_at}.reverse


    @total = @posts.count
    @geocoded_posts = @user.posts.geocoded
    @markers = @posts.map do |post|
      {
        lat: post.latitude,
        lng: post.longitude,
        info_window: render_to_string(partial: "posts/info_window", locals: {post: post}),
        image_url: helpers.asset_url("pink-gummy-removebg-preview.png")
      }
    end
    @post_likes_given = @user.post_likes.count

    @post_likes_received = 0
    @posts.each do |post|
      @post_likes_received += post.post_likes.count
    end

    @saved_posts = SavedPost.where(user_id: @user.id)
  end

  def edit_prof_pic
    @user = current_user
  end

  def update_prof_pic
    @user = current_user
    if params[:user]
      current_user.prof_pic.attach(io: params[:user]["image"].tempfile, filename: params[:user]["image"].original_filename)
      temp_file.rewind
      if current_user.save!
        flash[:notice] = "Profile picture updated"
        redirect_to profile_path
      else

        flash[:alert] = "Error uploading file"
        redirect_to edit_prof_pic_path
      end
    end
  end

  def upload_post_image
    @post = Post.new
  end

  def destroy_sesh
    sign_out_and_redirect(current_user)
  end
end

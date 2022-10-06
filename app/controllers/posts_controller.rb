require 'carrierwave/orm/activerecord'
class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    page = params[:page] || 1
    per  = params[:per] || 10

    @all_posts = Post.all
    @posts = @all_posts.sort_by {|posts| posts.created_at}.reverse
    @user = current_user

    @selected = params[:order]

    @likes_of_posts_with_i = @posts.each_with_index.map {|post, index| [post.post_likes.count, index]}
    @likes_of_posts_with_i.sort_by! {|likes, index| likes}.reverse
    @index_of_likes_of_posts_with_i = @likes_of_posts_with_i.map {|likes, index| index}
    @posts_with_i = @index_of_likes_of_posts_with_i.map {|index| @posts[index]}

    # If no filter or "all" mark all posts
    if params[:filter] == "all" || params[:filter] == nil
      # @posts = Post.all
      @markers = @posts.map do |post|
        {
          lat: post.latitude,
          lng: post.longitude,
          info_window: render_to_string(partial: "info_window", locals: {post: post}),
          image_url: helpers.asset_url("pink-gummy-removebg-preview.png")
        }
      end

    # If there is a filter
    else
      @posts = PostTag.where(tag: params[:filter]).map {|post_tag| post_tag.post}

      @markers = @posts.map do |post|
      {
        lat: post.latitude,
        lng: post.longitude,
        info_window: render_to_string(partial: "info_window", locals: {post: post}),
        image_url: helpers.asset_url("pink-gummy-removebg-preview.png")
      }
      end
    end

    case params[:order]
    when "newest"
      @posts = @posts.sort_by { |post| post.created_at }.reverse!
    when "oldest"
      @posts = @posts.sort_by { |post| post.created_at }
    when "highest"
      @posts = @posts.sort_by { |post| post.rating }.reverse!
    when "lowest"
      @posts = @posts.sort_by { |post| post.rating }
    when "popular"
      @posts = @posts_with_i.reverse.select { |post| post.post_likes.count >= 1 }
    end

    if params[:filter]
      arr = ["all", "alcohol", "beverage", "bread", "candy", "cereal","chips","chocolate", "cookies","crackers","dip", "frozen", "fruit", "gummies","icecream","nuts","pastry","spread"]
      index = arr.find_index(params[:filter])
      @selection_arr = ["", "","", "","", "","","","","","","","","","","","",""]
      @selection_arr[index] = "selected"

    else
      @selection_arr = ["selected", "","", "","", "","","","","","","","","","","",""]

    end

    @posts = Kaminari.paginate_array(@posts).page(page).per(per)

    # @user = current_user
    # @post = Post.find(params[:post_id])
    # @post_like = PostLike.new
    # @liked_post = PostLike.find_by(post_id: @post.id, user_id: @user.id)
  end

  def show
    @user = current_user
    @post = Post.find(params[:id])
    @post_likes = PostLike.new
    @liked_post = PostLike.find_by(post_id: @post.id, user_id: @user.id)
    @markers = [{
        lat: @post.latitude,
        lng: @post.longitude,
        info_window: render_to_string(partial: "info_window", locals: {post: @post}),
        image_url: helpers.asset_url("pink-gummy-removebg-preview.png")
      }]
    @post_comment = PostComment.new
    @current_user_id = current_user.id
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.user_id = @user.id
    # @post.image_url = "https://snacky-production.s3.eu-west-2.amazonaws.com/" + @post.image.key

    # @post.image = params[:file]

    # @post.image_url = []

    # @post.images.each do |img, key|
    #   @post.image_url << `https://snacky-production.s3.eu-west-2.amazonaws.com/ + #{@post.img.key}`
    # end

    if @post.save
      redirect_to post_path(@post), notice: "review posted 🎉"
    else
      flash[:alert] = "please fill in all fields!"
      render new_post_path, alert: "please fill in all fields!"
    end

  end

  def edit
    @post = Post.find(params[:id])
    @user = @post.user_id

    if @user != current_user
      redirect_to post_path(@post), alert: "not your post!"

    end
  end

  def update
    @post = Post.find(params[:id])
    if params[:post] && params[:post][:images]
      @post.images.attach(params[:post][:images])
      @post.save
      redirect_to edit_post_path(@post)
    else
      @post.update(post_params)
      redirect_to post_path(@post)

    end
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  def remove_image
    @post = Post.find(params[:post_id].to_i)
    @post.images[params[:image_index].to_i].purge
    redirect_to edit_post_path(@post)
  end


  private

  def post_params
    params.require(:post).permit(:title, :review, :rating, :image, :country, :brand, :user_id, :order, :address, :image_url, {images: []})
  end
end

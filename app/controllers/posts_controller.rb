class PostsController < ApplicationController
  skip_before_action :authenticate_user!, only: [ :index, :show ]

  def index
    page = params[:page] || 1
    per  = params[:per] || 10

    @all_posts = Post.all
    @posts = @all_posts.sort_by {|posts| posts.created_at}.reverse
    @user = current_user

    if params[:query].present?
      @posts = @all_posts.global_search(params[:query])
    else
      @message = "No results found for #{params[:query]}"
    end

    @selected = params[:order]

    @likes_of_posts_with_i = @posts.each_with_index.map {|post, index| [post.post_likes.count, index]}
    @likes_of_posts_with_i.sort_by! {|likes, index| likes}.reverse
    @index_of_likes_of_posts_with_i = @likes_of_posts_with_i.map {|likes, index| index}
    @posts_with_i = @index_of_likes_of_posts_with_i.map {|index| @posts[index]}

    case params[:order]
    when "newest"
      @posts = Post.all.order(:created_at => :desc)
    when "oldest"
      @posts = Post.all.order(:created_at => :asc)
    when "highest"
      @posts = Post.all.order(:rating => :desc)

    when "lowest"
      @posts = Post.all.order(:rating => :asc)
    when "popular"
      @posts = @posts_with_i.reverse
    end

    @geocoded_posts = Post.all.geocoded
    @markers = @geocoded_posts.map do |post|
    {
      lat: post.latitude,
      lng: post.longitude,
      info_window: render_to_string(partial: "info_window", locals: {post: post}),
      image_url: helpers.asset_url("pink-gummy-removebg-preview.png")
    }
    end

    if params[:filter] == "all" || params[:filter] == nil
      @posts = Post.all
      @markers = @geocoded_posts.map do |post|
        {
          lat: post.latitude,
          lng: post.longitude,
          info_window: render_to_string(partial: "info_window", locals: {post: post}),
          image_url: helpers.asset_url("pink-gummy-removebg-preview.png")
        }
        end
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

    if params[:filter]
      arr = ["all", "chips", "chocolate", "alcohol", "gummies", "candy","pastry"]
      index = arr.find_index(params[:filter])
      @selection_arr = ["", "","", "","", "",""]
      @selection_arr[index] = "selected"
    else
      @posts = @all_posts.sort_by {|posts| posts.created_at}.reverse
      @selection_arr = ["selected", "","", "","", "",""]
    end

    @posts = Kaminari.paginate_array(@posts).page(page).per(per)
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
  end

  def new
    @post = Post.new
  end

  def create
    @user = current_user
    @post = Post.new(post_params)
    @post.user_id = @user.id

    if @post.save
      redirect_to post_path(@post), notice: "posted 🎉"
    else
      flash[:alert] = "please fill in all fields!"
      render new_post_path, alert: "please fill in all fields!"
    end

  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    @post.update(post_params)
    redirect_to post_path(@post)
  end

  def destroy
    @post = Post.find(params[:id])
    @post.destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :review, :rating, :image, :country, :brand, :user_id, :order, :address)
  end
end

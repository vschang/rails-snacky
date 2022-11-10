class PostLikesController < ApplicationController
  def create
    @post_like = PostLike.new
    @post = Post.find(params[:post_id])
    @post_like.user = current_user
    @post_like.post = @post
    user = current_user

    @liked_post = PostLike.find_by(post_id: @post.id, user_id: user.id)

    if @liked_post
      @liked_post.destroy
      case params["page"]
      when "show"
        redirect_to post_path(@post)
      when "index"
        redirect_to posts_path(@post_like.post, anchor: "post-#{@post.id}"), notice: "unliked!"
      end
    else
      @post_like.user = user
      @post_like.post = @post
      case params["page"]
      when "show"
        redirect_to post_path(@post) if @post_like.save!
      when "index"
        if @post_like.save
          redirect_to posts_path(@post_like.post, anchor: "post_#{@post.id}"), notice: "liked!"
        else
          render "posts/show", alert: "not saved 😔"
        end
      end
    end
  end

  # def destroy
  #   @post = Post.find(params[:id])
  #   @post_like = PostLike.find_by(post_id: @post.id, user_id: current_user.id)
  #   @post_like.destroy
  # end

  private

  def post_like_params
    params.require(:post_like).permit(:user_id, :post_id)
  end
end

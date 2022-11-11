class PostLikesController < ApplicationController
  def create
    @post_like = PostLike.new
    @post = Post.find(params[:post_id])
    # @post_like.user = current_user
    # @post_like.post = @post
    user = current_user

    @liked_post = PostLike.all.find_by(user: user, post: @post)

    if @liked_post
      # case params["page"]
      # when "show"
        if @liked_post.destroy
          redirect_to post_path(@liked_post.post_id)
        end
      # when "index"
      #   if @liked_post.destroy
      #     # raise
      #     redirect_to posts_path(@liked_post.post, anchor: "post-#{@post.id}"), notice: "unsaved!"
      #   end
      # end
    else
      @post_like.user = user
      @post_like.post = @post
      # case params["page"]
      # when "show"
        redirect_to post_path(@post) if @post_like.save!
      # when "index"
      #   if @post_like.save
      #     # raise
      #     redirect_to posts_path(@post_like.post, anchor: "post_#{@post.id}"), notice: "liked!"
      #   else
      #     render "posts/show", alert: "not saved 😔"
      #   end
      # end
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

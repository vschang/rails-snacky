class SavedPostsController < ApplicationController
  def create
    @user = current_user
    @post = Post.find(params["format"].to_i)
    @saved_post = SavedPost.new

    @found_post = SavedPost.find_by(user: @user.id, post: @post.id)

    if @found_post
      @found_post.destroy
      redirect_to posts_path(@saved_post.post, anchor: "post-#{@post.id}"), notice: "unsaved!"
    else
      @saved_post.user = @user
      @saved_post.post = @post
      if @saved_post.save
        redirect_to posts_path(@saved_post.post, anchor: "post-#{@post.id}"), notice: "saved!"
      else
        render "posts/show", alert: "not saved 😔"
      end
    end
  end
end

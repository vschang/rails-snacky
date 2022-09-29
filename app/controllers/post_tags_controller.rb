class PostTagsController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    @post_tag = PostTag.new(post_tag_params)
    @post_tag.post = @post

    # if @post_tag.save
    #   redirect_to post_path(@post)
    # else
    #   flash[:alert] = "#{@post_tag.tag} tag has already been added"
    #   redirect_to post_path(@post)
    # end

    respond_to do |format|
      if @post_tag.save
        p "POST SAVED"
        format.json # Follow the classic Rails flow and look for a create.json view
      else
        p "POST ERROR"
        format.json {render json: @post_tag.errors.full_messages, status: 406}
      end
    end
  end

  def destroy
    @post_tag = PostTag.find(params[:id])
    @post = Post.find(params[:post_id])
    @post_tag.destroy
    redirect_to post_path(@post)
  end

  private

  def post_tag_params
    params.require(:post_tag).permit(:tag, :post_id, :id)
  end
end

if @post_comment.persisted?
  json.form render(partial: "post_comments/form", formats: :html, locals: {post: @post, post_comment: PostComment.new})
  json.inserted_item render(partial: "post_comments/post_comment", formats: :html, locals: {post_comment: @post_comment})
else
  json.form render(partial: "post_comments/form", formats: :html, locals: {post: @post, post_comment: @post_comment})
end

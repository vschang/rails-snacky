
if @post_tag.persisted?
  json.form render(partial: "post_tags/form", formats: :html, locals: {post: @post, post_tag: PostTag.new})
  json.inserted_tag render(partial: "post_tags/post_tag", formats: :html, locals: {post_tag: @post_tag})
else
  json.form render(partial: "post_tags/form", formats: :html, locals: {post: @post, post_tag: @post_tag})
end

class PostsController < ApplicationController

  def create
    the_post = Post.new
    the_post.title = params.fetch("query_title")
    the_post.body = params.fetch("query_body")
    the_post.expires_on = params.fetch("query_expires_on")
    the_post.board_id = params.fetch("query_board_id")

    if the_post.valid?
      the_post.save
      redirect_to("/posts", { :notice => "Post created successfully." })
    else
      redirect_to("/posts", { :alert => the_post.errors.full_messages.to_sentence })
    end
  end

end

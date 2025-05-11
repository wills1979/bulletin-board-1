class BoardsController < ApplicationController
  def index
    matching_boards = Board.all

    @list_of_boards = matching_boards.order({ :created_at => :desc })

    render({ :template => "boards/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_boards = Board.where({ :id => the_id })

    @the_board = matching_boards.at(0)

    @active_posts = Post.where({ :board_id => the_id}).where("expires_on > ?", Date.today)
    
    @expired_posts = Post.where({ :board_id => the_id}).where("expires_on <= ?", Date.today)

    render({ :template => "boards/show" })
  end

  def create
    the_board = Board.new
    the_board.name = params.fetch("query_name")

    if the_board.valid?
      the_board.save
      redirect_to("/boards", { :notice => "Board created successfully." })
    else
      redirect_to("/boards", { :alert => the_board.errors.full_messages.to_sentence })
    end
  end

end

class BookCommentsController < ApplicationController

  	before_action :correct_user, only: [:destroy]

	def create
		book = Book.find(params[:book_id])
		comment = current_user.book_comments.new(book_comment_params)
		comment.book_id = book.id
		comment.save
		redirect_to book_path(book)
	end

	def destroy
		comment.destroy
    	flash[:success] = 'comment deleted'
    	redirect_back(fallback_location: root_path)
	end

	def correct_user
    	comment = current_user.comments.find_by(id: params[:id])
    unless comment
      redirect_to root_url
    end
  	end


	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end
end

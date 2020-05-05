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
		book = Book.find(params[:book_id])
		comment = BookComment.find(params[:id])
		comment.destroy
    	flash[:success] = 'comment deleted'
    	redirect_to book_path(book)
	end


	private
	def book_comment_params
		params.require(:book_comment).permit(:comment)
	end

	def correct_user
    	comment = current_user.book_comments.find_by(id: params[:id])
  	end

end

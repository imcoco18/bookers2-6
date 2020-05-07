class SearchController < ApplicationController

	def search
	@model = params["search"]["model"]
    @content = params["search"]["content"]
    @method = params["search"]["method"]
    @records = search_for(@model,@content,@method).page(params[:page]).per(5)
	end

	private
	    def search_for(model,content,method)
	        if model == 'customer'
	           method == 'partial'
	           Customer.where('family_name LIKE ?', '%'+content+'%')
	        else
	           method == 'partial'
	           Item.where('name LIKE ?', '%'+content+'%')
	        end
	    end
end

class CategoriesController < ApplicationController
	load_and_authorize_resource

	def index
		@categories = Category.all
	end

	def show
		@category = Category.find(params[:id])
		@category_attractions = @category.attractions.all
	end

	def new
		@category = Category.new
	end

	def edit
    	@category = Category.find(params[:id])
  	end

  	def create
    	@category = Category.create(category_params)

	    if @category.save
	    	redirect_to categories_path, :flash => { :success => 'Category created.' }
	    else
	    	render :action => 'index'
	    end
  	end

  	def update
    	@category = Category.find(params[:id])

    
	    if @category.update_attributes(category_params)
	    	redirect_to categories_path, :flash => { :success => 'Category details updated.' }
	    else
	      	render :action => 'index', :flash => { :error => 'Unable to update details.' }
	    end
  	end

  	def destroy
  		@category = Category.find(params[:id])
    	@category.destroy
    	redirect_to categories_path, :flash => { :success => 'Category deleted.' }
  	end

	private
  	def category_params

    	params.require(:category)
    
	    if can? :manage, Category
	      params[:category].permit(:name)
	    end
  	end
end

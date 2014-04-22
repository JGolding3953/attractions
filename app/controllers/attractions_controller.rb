class AttractionsController < ApplicationController
  load_and_authorize_resource

	def index
		@attractions = Attraction.all
	end

	def show
		@attraction = Attraction.find(params[:id])
	end

	def destroy
    	@attraction = Attraction.find(params[:id])
    	@attraction.destroy
    	redirect_to attractions_path, :flash => { :success => 'Attraction deleted.' }
  	end

  	def new
  		@attraction = Attraction.new
  	end

  	def edit
    	@attraction = Attraction.find(params[:id])
  	end

  	def create
    	@attraction = Attraction.create(attraction_params)

    	#params[:attraction][:category_id] ||= '1'

	    if @attraction.save
	    	redirect_to attractions_path, :flash => { :success => 'Attraction created.' }
	    else
	    	render :action => 'index'
	    end
  	end

  	def update
    	@attraction = Attraction.find(params[:id])

    
	    if @attraction.update_attributes(attraction_params)
	    	redirect_to @attraction, :flash => { :success => 'Attraction details updated.' }
	    else
	      	render :action => 'index', :flash => { :error => 'Unable to update details.' }
	    end
  	end

  	private
  	def attraction_params

    	params.require(:attraction)
    
	    if can? :manage, Attraction
	      params[:attraction].permit(:name, :summary, :description, :area, :rating, :website, :imageurl, :category_id)
	    end
  	end
end

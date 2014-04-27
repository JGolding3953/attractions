class ReviewsController < ApplicationController
  before_filter :find_parent
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_reviews, only: [:index]
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new      
    @review = @parent.reviews.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.create(review_params)
    
    @review.user_id = current_user.id
    @review.attraction_id = params[:attraction_id]

    respond_to do |format|
      if @review.save
        format.html { redirect_to [@parent, @review], notice: 'Review was successfully created.' }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to [@parent, @review], notice: 'Review was successfully updated.' }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      if @reviews != nil
        format.html { redirect_to @reviews, notice: 'Review deleted' }
        format.json { head :no_content }
      else
        format.html { redirect_to @parent, notice: 'Review deleted' }
        format.json { head :no_content }
      end
    end
  end

  # Reviews are nested for both attraction (as object of reviews) and user (as author of reviews) routes, 
  # so need to establish which to use to populate @parent variable to use in all views.
  
  def find_parent
    @parent = nil
    
    if params[:attraction_id]
      @parent = Attraction.find(params[:attraction_id])
    elsif params[:user_id]
      @parent = User.find(params[:user_id])
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end
  
    def set_reviews
      @reviews = @parent.reviews.all
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:attraction_id, :user_id, :comments, :rating)
    end
end

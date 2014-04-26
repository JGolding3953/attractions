class ReviewsController < ApplicationController
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_filter :find_parent

  # GET /reviews
  # GET /reviews.json
  def index
    @reviews = @parent.reviews.all
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new      
    if signed_in?
      @review = @parent.reviews.new
      session[:return_to] = nil 
    else
      session[:return_to] = request.url 
      redirect_to new_user_session_path, alert: "You need to login to write a review"
    end
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
      format.html { redirect_to @reviews }
      format.json { head :no_content }
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

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:attraction_id, :user_id, :comments, :rating)
    end
end

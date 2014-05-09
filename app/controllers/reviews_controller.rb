class ReviewsController < ApplicationController  
  include ListsHelper
  include ApplicationHelper

  before_filter :find_parent
  before_action :set_review, only: [:show, :edit, :update, :destroy]
  before_action :set_reviews, only: [:index, :destroy]
  before_filter :authenticate_user!, only: [:new, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json
  def index
     if @attraction
      if user_signed_in?
        user_review_check(current_user.id, @attraction.id)
      end
    end
  end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
    if user_signed_in?
      user_review_check(current_user.id, @review.attraction.id)
    end
  end

  # GET /reviews/new
  def new
    if @attraction
      if user_signed_in?
        user_review_check(current_user.id, @attraction)
      end
    end
    
    if @user
       respond_to do |format|
          format.html { redirect_to user_reviews_path, notice: 'You are not authorised to do this.' }
          format.json { head :no_content }
       end
    elsif @user_has_reviewed
      respond_to do |format|
        format.html { redirect_to edit_polymorphic_path([@parent, @user_review]) }
          format.json { head :no_content }
       end
    else    
      @review = @parent.reviews.new
    end
  end

  # GET /reviews/1/edit
  def edit
    if (current_user.id != @review.user_id) && (cannot? :manage, :all)
      respond_to do |format|
        if params[:attraction_id]
          format.html { redirect_to attraction_reviews_path, notice: 'You are not authorised to do this.' }
          format.json { head :no_content }
        elsif params[:user_id]
          format.html { redirect_to user_reviews_path, notice: 'You are not authorised to do this.' }
          format.json { head :no_content }
        end
      end
    end
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
    if (current_user.id != @review.user_id) && (cannot? :manage, :all)
     respond_to do |format|
        if params[:attraction_id]
          format.html { redirect_to attraction_reviews_path, notice: 'You are not authorised to do this.' }
          format.json { head :no_content }
        elsif params[:user_id]
          format.html { redirect_to user_reviews_path, notice: 'You are not authorised to do this.' }
          format.json { head :no_content }
        end
      end
    end
    
    @review.destroy
    respond_to do |format|
      if @reviews != nil
        if params[:attraction_id]
          format.html { redirect_to attraction_reviews_path, notice: 'Review deleted' }
          format.json { head :no_content }
        elsif params[:user_id]
          format.html { redirect_to user_reviews_path, notice: 'Review deleted' }
          format.json { head :no_content }
        end
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
      set_ca_limit(@parent.category.id, @parent.id)
      @attraction = @parent
    elsif params[:user_id]
      @parent = User.find(params[:user_id])
      @user = @parent
    end
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
      set_ca_limit(@review.attraction.category.id, @review.attraction.id)
    end
  
    def set_reviews
      @reviews = @parent.reviews.all
    end
  
    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:attraction_id, :user_id, :title, :comments, :rating)
    end
end

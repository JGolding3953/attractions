class AdminController < ApplicationController
  before_filter :authenticate_user!

  def admin
    if can? :manage, :all
      @attractions = Attraction.all
      @users = User.all
      @categories = Category.all
    else
      respond_to do |format|
        format.html { redirect_to root_path, notice: 'You are not authorised to view this page.' }
        format.json { head :no_content }
      end
    end
  end
end
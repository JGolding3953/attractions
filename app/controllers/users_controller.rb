class UsersController < ApplicationController
  load_and_authorize_resource

	def index
    if user_signed_in?
      @users = User.all
    else
      redirect_to new_user_session_path
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def create
    @user = User.create(user_params)

    if @user.save
      if can? :manage, User
        redirect_to users_path, :flash => { :success => 'User was successfully created.' }
      else
        sign_in(@user, :bypass => true)
        redirect_to @user, :flash => { :success => 'You have successfully created an account.' }

      end
    else
      render :action => 'new'
    end
  end

  def update
    @user = User.find(params[:id])
    
    if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    if @user.update_attributes(user_params)
      sign_in(@user, :bypass => true) if @user == current_user
      redirect_to @user, :flash => { :success => 'User was successfully updated.' }
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_path, :flash => { :success => 'User was successfully deleted.' }
  end

  private
  def user_params

    params.require(:user)
    
    if can? :manage, User
      params[:user].permit(:email, :password, :password_confirmation, :remember_me, role_ids:[])
    else
      params[:user].permit(:email, :password, :password_confirmation, :remember_me)
    end
  end
end

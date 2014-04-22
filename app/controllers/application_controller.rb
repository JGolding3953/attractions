class ApplicationController < ActionController::Base
  before_filter :authenticate_user!
  before_filter do
  		resource = controller_path.singularize.gsub('/', '_').to_sym
  		method = "#{resource}_params"
  		params[resource] &&= send(method) if respond_to?(method, true)
  	end
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  rescue_from CanCan::AccessDenied do |exception|
  		redirect_to root_path, :alert => exception.message
  	end
end

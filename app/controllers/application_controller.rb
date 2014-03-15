class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  after_filter :store_location
  before_filter :configure_permitted_parameters, if: :devise_controller?

	
  
  def store_location
	  # store last url - this is needed for post-login redirect to whatever the user last visited.
	  if (request.fullpath != "/signin" &&
	      request.fullpath != "/signup" &&
	      request.fullpath != "/users/password" &&
	      request.fullpath != "/signout" &&
	      !request.xhr?) # don't store ajax calls
	  #binding.pry
	    session[:previous_url] = request.fullpath 
	  end
	end	

	def after_sign_in_path_for(resource)
	  session[:previous_url] || root_path
	end

	def login_required
		if current_user.blank?
			respond_to do |format|
				format.html{
  				authenticate_user!
  			}
  			format.js{
  				render :partial => "common/not_logined"
  			}
  			format.all{
  				head(:unauthorized)
  			}
			end
		end
	end

  protected

	  def configure_permitted_parameters
	    devise_parameter_sanitizer.for(:sign_up) { |u| 
		      u.permit(:email, :password, :password_confirmation, :name) 
		   }
	  end


end

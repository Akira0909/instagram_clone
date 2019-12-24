class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
	before_action :set_search
	
	def set_search
    @search = Micropost.ransack(params[:q])
    @search_microposts = @search.result(distinct: true)
	end
	
  protected

		def configure_permitted_parameters
	    added_attrs = [ :name, :user_name, :sex, :website, :self_introduction,
	    	:phone, :image_name, :email, :password ]
	    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
	    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
	    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
		end
		    
    def search_params
    params.require(:q).permit(:content_eq)
    end
  
end
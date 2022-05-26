class ApplicationController < ActionController::Base

  # https://edgeapi.rubyonrails.org/classes/ActiveSupport/Rescuable/ClassMethods.htmlad
  rescue_from 'MyAppError::Base' do |exception|
    render xml: exception, status: 500
  end

    private
  
    def current_user
      if session[:user_id].present?
        @current_user ||= User.find session[:user_id]
      end
    end
    helper_method :current_user
  
    def user_signed_in?
      current_user.present?
    end
    helper_method :user_signed_in?
  
    def authenticate_user!
      unless user_signed_in?
        flash[:danger] = "Please sign in!"
        redirect_to new_session_path
      end
    end
  end
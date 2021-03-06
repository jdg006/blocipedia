class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
   
    private

   def require_sign_in
     unless current_user
       flash[:alert] = "You must be logged in to do that"

       redirect_to new_user_session_path
     end
   end
   
   def authorized_for_private_wiki_index
       if current_user && admin
           elsif current_user && premium
   end
   
   
  end
end

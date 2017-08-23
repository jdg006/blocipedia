class WelcomeController < ApplicationController
 
  def downgrade
    current_user.update_attribute(:role, 'standard')
    redirect_to welcome_index_path
  end
 
  def index
  end

  def about
  end

end

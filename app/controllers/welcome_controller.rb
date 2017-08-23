class WelcomeController < ApplicationController
 
  def downgrade
    current_user.update_attribute(:role, 'standard')
    current_user.wikis.each do |wiki|
      wiki.update_attribute(:private, false)
    end
    redirect_to welcome_index_path
  end
 
  def index
  end

  def about
  end

end

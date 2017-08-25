class CollaboratorsController < ApplicationController
    def index
     @collaborators = Collaborator.all
    end
  
  def show
    @collaborator = Collaborator.find(params[:id])
  end

  def new 
    @collaborator = Collaborator.new
  end

  def edit
    @collaborator = Collaborator.find(params[:id])
  end
  
  def update
     @collaborator = Collaborator.find(params[:id])
     @collaborator.assign_attributes(collaborator_params)
 
     if @collaborator.save
       flash[:notice] = "Collaborators were updated."
       redirect_to [@wiki]
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :edit
     end
   end
  
  def create
     collaborator_email = params[:collaborator][:user]
     collaborator_wiki = params[:collaborator][:wiki]
     @wiki = Wiki.where(id: collaborator_wiki).take
    
     @wiki.collaborators.each do |col|
           if col.user.email == collaborator_email
             flash[:notice]= "That person is already a collaborator"
            redirect_to edit_wiki_path(@wiki)
            return
            end
        end
        
    
    
     @collaborator = Collaborator.new
     @collaborator.user = User.where(email: collaborator_email).take
     @collaborator.wiki = @wiki
    
     if @collaborator.save
         flash[:notice] = "\"#{@collaborator.user.email}\" was added successfully."
       redirect_to edit_wiki_path(@collaborator.wiki)
     else
       flash.now[:alert] = "There was an error saving the Wiki. Please try again."
       render :new
     end
   end
   
   def destroy
     @collaborator = Collaborator.find(params[:id])
     @wiki = @collaborator.wiki
     if @collaborator.destroy
       flash[:notice] = "\"#{@collaborator.user.email}\" was deleted successfully."
       redirect_to edit_wiki_path(@wiki)
     else
       flash.now[:alert] = "There was an error deleting the collaborator."
       render :show
     end
   end
   
   private
   
   def collaborator_params
     params.require(:collaborator).permit(:user, :wiki)
   end
   
   def authorize_user
     unless current_user.premium? || current_user.role == 'admin'
       flash[:alert] = "You must be premium to do that."
       redirect_to wikis_path
     end
   end
   
   
end

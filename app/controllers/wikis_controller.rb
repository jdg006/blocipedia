class WikisController < ApplicationController
  before_action :require_sign_in, except: [:show, :index]
 # before_action :authorize_user, except: [:show, :index, :edit, :update]
  
  def index
     @wikis = Wiki.all
  end
  
  def show
    @wiki = Wiki.find(params[:id])
  end

  def new
    @wiki = Wiki.new
  end

  def edit
    @wiki = Wiki.find(params[:id])
  end
  
  def update
     @wiki = Wiki.find(params[:id])
     @wiki.assign_attributes(wiki_params)
 
     if @wiki.save
       flash[:notice] = "Wiki was updated."
       redirect_to [@wiki]
     else
       flash.now[:alert] = "There was an error saving the wiki. Please try again."
       render :edit
     end
   end
  
  def create
     @wiki = Wiki.new
     @wiki.title = params[:wiki][:title]
     @wiki.body = params[:wiki][:body]
     @wiki.private = params[:wiki][:private]
     @wiki.user = current_user

     if @wiki.save
       flash[:notice] = "Wiki was saved."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error saving the Wiki. Please try again."
       render :new
     end
   end
   
   def destroy
     @wiki = Wiki.find(params[:id])
 
     if @wiki.destroy
       flash[:notice] = "\"#{@wiki.title}\" was deleted successfully."
       redirect_to @wiki
     else
       flash.now[:alert] = "There was an error deleting the wiki."
       render :show
     end
   end
   
   private
   
   def wiki_params
     params.require(:wiki).permit(:title, :body, :private)
   end
   
   def authorize_user
     unless current_user.premium? || current_user.role == 'admin' 
       flash[:alert] = "You must be premium to do that."
       redirect_to wikis_path
     end
   end
end

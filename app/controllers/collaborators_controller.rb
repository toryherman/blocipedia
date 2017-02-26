class CollaboratorsController < ApplicationController
  def create
    @wiki = Wiki.find(params[:wiki_id])
    @user = User.where('email LIKE ?', "%#{params[:search]}%").first

    if @user
      unless @wiki.collaborators.any?{ |c| c.user_id == @user.id }
        @collaborator = Collaborator.new(wiki: @wiki, user: @user)
      else
        flash[:alert] = "That user is already a collaborator."
        redirect_back(fallback_location: @wiki)
        return
      end
    else
      flash[:alert] = "That user is invalid. Please try again."
      rredirect_back(fallback_location: @wiki)
      return
    end

    if @collaborator.save
      flash[:notice] = "Collaborator added."
    else
      flash[:alert] = "There was an error adding the collaborator. Please try again."
    end

    redirect_back(fallback_location: @wiki)
  end

  def destroy
    @wiki = Wiki.find(params[:wiki_id])
    @collaborator = @wiki.collaborators.find(params[:id])

    if @collaborator.destroy
      flash[:notice] = "Collaborator removed."
    else
      flash[:alert] = "There was an error removing the collaborator."
    end

    redirect_back(fallback_location: @wiki)
  end
end

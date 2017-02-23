class CollaboratorsController < ApplicationController
  def create
    wiki = Wiki.find(params[:wiki_id])

    unless wiki.collaborators.find_by_user_id(current_user.id)
      collaborator = current_user.collaborators.build(wiki: wiki)
    else
      flash[:alert] = "That user is already a collaborator."
      redirect_to :back
      return
    end

    if collaborator.save
      flash[:notice] = "Collaborator added."
    else
      flash[:alert] = "There was an error adding the collaborator."
    end

    redirect_to :back
  end

  def destroy
    wiki = Wiki.find(params[:wiki_id])
    collaborator = wiki.collaborators.find(params[:id])

    if collaborator.destroy
      flash[:notice] = "Collaborator removed."
    else
      flash[:alert] = "There was an error removing the collaborator."
    end

    redirect_to :back
  end
end

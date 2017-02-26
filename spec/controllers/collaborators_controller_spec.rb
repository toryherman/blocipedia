require 'rails_helper'

RSpec.describe CollaboratorsController, type: :controller do
  before(:each) do
    request.env["HTTP_REFERER"] = "last page"
  end

  let(:my_admin) { create(:user, role: "admin") }
  let(:premium_user) { create(:user, role: "premium") }
  let(:private_wiki) { create(:wiki, user: my_admin, private: true) }

  describe "POST #create" do
    it "redirects back to edit view" do
      post :create, params: { wiki_id: private_wiki.id, user_id: premium_user.id }
      expect(response).to redirect_to "last page"
    end

    it "creates a new collaborator" do
      expect{
        post :create, params: { wiki_id: private_wiki.id, user_id: premium_user.id }
      }.to change(Collaborator, :count).by(1)
    end
  end

  describe "DELETE #destroy" do
    it "removes collaborator" do
      collaborator = private_wiki.collaborators.where(user: premium_user).create
      delete :destroy, params: { wiki_id: private_wiki.id, id: collaborator.id }
      expect(private_wiki.collaborators.count).to eq(0)
    end
  end
end

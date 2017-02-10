require 'rails_helper'

RSpec.describe Users::SessionsController, type: :controller do
  before(:each) {
    @request.env["devise.mapping"] = Devise.mappings[:user]
  }

  let(:my_user) { create(:user) }
  let(:other_user) { create(:user) }

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST sessions" do
    it "initializes a session" do
      sign_in my_user
      expect(session).not_to be_empty
    end

    it "does not initialize a session without user info" do
      post :create, params: { session: { email: my_user.email } }
      expect(session).to be_empty
      expect(flash.now[:alert]).to be_present
    end

    it "flashes #error and renders #new with bad email address" do
      post :create, params: { session: { email: "does not exist" } }
      expect(flash.now[:alert]).to be_present
      expect(response).to render_template :new
    end

    it "redirects to the root view" do
      sign_in my_user
      expect(response).to redirect_to(root_path)
    end
  end

  describe "DELETE sessions" do
    it "redirects to the root view" do
      delete :destroy, params: { id: my_user.id }
      expect(response).to redirect_to(root_path)
    end

    it "deletes the user's session" do
      delete :destroy, params: { id: my_user.id }
      expect(assigns(:session)).to be_nil
    end

    it "flashes notice" do
      delete :destroy, params: { id: my_user.id }
      expect(flash[:notice]).to be_present
    end
  end
end

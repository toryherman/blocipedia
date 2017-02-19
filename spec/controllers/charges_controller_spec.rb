require 'rails_helper'
require 'stripe_mock'

RSpec.describe ChargesController, type: :controller do
  let(:my_user) { create(:user) }
  let(:stripe_helper) { StripeMock.create_test_helper }

  before do
    StripeMock.start
    sign_in my_user
    controller.stub(:current_user) { my_user }
  end
  
  after { StripeMock.stop }

  describe "GET #new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create" do
    it "successful transaction redirects to root path" do
      post :create
      expect(response).to redirect_to root_path
    end

    it "card error redirects to new charge path" do
      StripeMock.prepare_card_error(:card_declined)
      expect(post :create).to redirect_to new_charge_path
    end

    it "upgrades user membership to premium" do
      post :create
      expect(my_user.role).to eq("premium")
    end
  end
end

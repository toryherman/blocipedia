require 'rails_helper'

RSpec.describe Users::RegistrationsController, type: :controller do
  before(:each) {
    @request.env["devise.mapping"] = Devise.mappings[:user]
  }

  let(:new_user_attributes) do
    {
      first_name: "First",
      last_name: "Last",
      email: "email@bloc.io",
      password: "password",
      password_confirmation: "password"
    }
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end

    it "instantiates a new user" do
      get :new
      expect(assigns(:user)).not_to be_nil
    end
  end

  describe "POST create" do
    it "returns an http redirect" do
      post :create, params: { user: new_user_attributes }
      expect(response).to have_http_status(:redirect)
    end

    it "creates a new user" do
      expect{
        post :create, params: { user: new_user_attributes }
      }.to change(User, :count).by(1)
    end

    it "sets first name properly" do
      post :create, params: { user: new_user_attributes }
      expect(assigns(:user).first_name).to eq new_user_attributes[:first_name]
    end

    it "sets last name properly" do
      post :create, params: { user: new_user_attributes }
      expect(assigns(:user).last_name).to eq new_user_attributes[:last_name]
    end

    it "sets email properly" do
      post :create, params: { user: new_user_attributes }
      expect(assigns(:user).email).to eq new_user_attributes[:email]
    end

    it "sets password properly" do
      post :create, params: { user: new_user_attributes }
      expect(assigns(:user).password).to eq new_user_attributes[:password]
    end

    it "sets password confirmation properly" do
      post :create, params: { user: new_user_attributes }
      expect(assigns(:user).password_confirmation).to eq new_user_attributes[:password_confirmation]
    end

    it "sends confirmation email" do
      mail_count = Devise.mailer.deliveries.count
      post :create, params: { user: new_user_attributes }
      expect(Devise.mailer.deliveries.count).to eq(mail_count + 1)
    end

    it "validation fails if email is already registered" do
      post :create, params: { user: new_user_attributes }
      expect{
        User.create!(new_user_attributes)
      }.to raise_error("Validation failed: Email has already been taken")
    end

    it "validation fails if email is invalid" do
      expect{
        User.create!(
          first_name: "First",
          last_name: "Last",
          email: "email",
          password: "password",
          password_confirmation: "password")
      }.to raise_error("Validation failed: Email is invalid")
    end

    it "validation fails if password and confirmation do not match" do
      expect{
        User.create!(
          first_name: "First",
          last_name: "Last",
          email: "email@bloc.io",
          password: "password",
          password_confirmation: "different")
      }.to raise_error("Validation failed: Password confirmation doesn't match Password")
    end

    it "validation fails if password is too short" do
      expect{
        User.create!(
          first_name: "First",
          last_name: "Last",
          email: "email@bloc.io",
          password: "pass",
          password_confirmation: "pass")
      }.to raise_error("Validation failed: Password is too short (minimum is 6 characters)")
    end

    it "validation fails if all fields aren't completed" do
      expect{
        User.create!(
          first_name: "First",
          last_name: "",
          email: "email@bloc.io",
          password: "password",
          password_confirmation: "password")
      }.to raise_error("Validation failed: Last name is too short (minimum is 1 character), Last name can't be blank")
    end
  end
end

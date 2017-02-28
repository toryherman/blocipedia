class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @wikis = policy_scope(@user.wikis)
  end
end

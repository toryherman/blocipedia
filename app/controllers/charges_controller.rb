class ChargesController < ApplicationController
  def new
  end

  def create
    # Amount in cents
    @amount = 1500

    customer = Stripe::Customer.create(
      email: params[:stripeEmail],
      source: params[:stripeToken]
    )

    charge = Stripe::Charge.create(
      customer: customer.id,
      amount: @amount,
      description: 'Upgrade to Premium Membership',
      currency: 'usd'
    )

    flash[:notice] = "Thanks for upgrading to a premium membership, #{current_user.first_name}!"
    current_user.role = "premium"
    current_user.save!
    redirect_to root_path

  rescue Stripe::CardError => e
    flash[:error] = e.message
    redirect_to new_charge_path
  end
end

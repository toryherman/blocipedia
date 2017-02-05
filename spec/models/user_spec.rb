require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  # Shoulda tests for username
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username) }
  it { is_expected.to validate_length_of(:username).is_at_least(1) }

  # Shoulda tests for first and last name
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }
  it { is_expected.to validate_length_of(:first_name).is_at_least(1) }
  it { is_expected.to validate_length_of(:last_name).is_at_least(1) }

  # Shoulda tests for email
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email) }

  # Shoulda tests for password
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "attributes" do
    it "should have first name, last name, and email attributes" do
      expect(user).to have_attributes(first_name: user.first_name, last_name: user.last_name, email: user.email)
    end
  end
end

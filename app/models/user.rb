class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable, :recoverable,
          :rememberable, :trackable, :validatable, :confirmable

  validates :first_name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :last_name, length: { minimum: 1, maximum: 100 }, presence: true
end

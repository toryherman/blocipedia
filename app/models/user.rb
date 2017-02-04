class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  validates :first_name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :last_name, length: { minimum: 1, maximum: 100 }, presence: true

  validates :password, length: { minimum: 6 }, presence: true

  validates :email,
            presence: true,
            uniqueness: { case_sensitve: false },
            length: { minimum: 3, maximum: 254 }
end

class User < ApplicationRecord
  attr_accessor :current_password
  
  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable, :recoverable,
          :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis, dependent: :destroy

  after_initialize :init

  validates :first_name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :last_name, length: { minimum: 1, maximum: 100 }, presence: true

  enum role: [:standard, :premium, :admin]

  private
  def init
    self.role ||= :standard if self.new_record?
  end
end

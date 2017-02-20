class User < ApplicationRecord
  include ActiveModel::Dirty
  attr_accessor :current_password

  # Include default devise modules. Others available are:
  # :lockable, :timeoutable and :omniauthable
  devise  :database_authenticatable, :registerable, :recoverable,
          :rememberable, :trackable, :validatable, :confirmable

  has_many :wikis, dependent: :destroy

  after_initialize :init
  after_save :downgrade_wikis

  validates :first_name, length: { minimum: 1, maximum: 100 }, presence: true
  validates :last_name, length: { minimum: 1, maximum: 100 }, presence: true

  enum role: [:standard, :premium, :admin]

  private
  
  def init
    self.role ||= :standard if self.new_record?
  end

  def downgrade_wikis
    if self.role_changed? && self.role == "standard"
      self.wikis.where(private: true).each do |w|
        w.private = false
        w.save!
      end
    end
  end
end

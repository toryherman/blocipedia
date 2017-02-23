class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators, dependent: :destroy

  after_initialize :init

  validates :title, length: { minimum: 5 }, presence: true
  validates :body, length: { minimum: 20 }, presence: true
  validates :private, inclusion: { in: [true, false] }
  validates :user, presence: true

  private
  def init
    self.private ||= false if self.new_record?
    self.updated_by ||= self.user_id
  end
end

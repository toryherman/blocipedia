class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      if user.present? && ( user.admin? || user.role == "premium" )
        scope.all
      else
        scope.where(private: false)
      end
    end
  end

  def index?
    true
  end

  def create?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.admin?
  end
end

class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      wikis = []
      all = scope.all

      if user.present?
        if user.admin?
          wikis = all
        elsif user.role == "premium"
          all.each do |wiki|
            if !wiki.private || wiki.created_by == user || wiki.collaborators.include?(user)
              wikis << wiki
            end
          end
        else
          all.each do |wiki|
            if !wiki.private || wiki.collaborators.include?(user)
              wikis << wiki
            end
          end
        end
      else
        wikis = scope.where(private: false)
      end

      wikis
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

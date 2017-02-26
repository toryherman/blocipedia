class WikiPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      wikis = []
      all = scope.all

      if user.present?
        if user.admin?
          wikis = scope.all
        elsif user.role == "premium"
          all.each do |wiki|
            if wiki.private == false || wiki.user == user
              wikis << wiki
            end

            wiki.collaborators.each do |c|
              if c.user_id == user.id
                wikis << wiki
              end
            end
          end
        else
          all.each do |wiki|
            if wiki.private == false
              wikis << wiki
            end

            wiki.collaborators.each do |c|
              if c.user_id == user.id
                wikis << wiki
              end
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

  def show?
    # public wiki
    record.private == false ||
    # private wiki owned by user
    (record.private == true && record.user == user) ||
    # user is admin
    user.admin? ||
    # user is a collaborator
    record.collaborators.any?{ |c| c.user_id == user.id }
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

class AlbumPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.where(user: user)
    end
  end

  def new?
    !!user
  end

  def create?
    record.user == user
  end

  def edit?
    create?
  end

  def update?
    create?
  end
end

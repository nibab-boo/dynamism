class BlogPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      scope.all.where(user: user)
    end
  end

  # def show?
  #   true
  # end

  # def update?
  #   record.user == user
  # end

end

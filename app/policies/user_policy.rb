class UserPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end   
  end

  def profile?
    !!user && record.email = user.email
  end

  def reset_api?
    profile?
  end
  
  def toggle?
    profile?
  end
end

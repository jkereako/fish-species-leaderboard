class UserPolicy < ApplicationPolicy
  def index?
    return false if user.nil?
    user.role == 'administrator'
  end

  def show?
    return false if user.nil?
    user.role == 'administrator'
  end
end

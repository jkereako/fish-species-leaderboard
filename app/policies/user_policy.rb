class UserPolicy < ApplicationPolicy
  def index?
    user.role == 'administrator'
  end
  def show?
    user.role == 'administrator'
  end
end

class UserInvitationPolicy < ApplicationPolicy
  def index?
    return false if user.nil?
    user.role == 'administrator'
  end

  def show?
    return false if user.nil?
    user.role == 'administrator'
  end

  def new?
    !user.nil?
  end

  def create?
    !user.nil?
  end

  def update?
    return false if user.nil?
    user.role == 'administrator'
  end

  def destroy?
    return false if user.nil?
    user.role == 'administrator'
  end
end

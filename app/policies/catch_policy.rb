class CatchPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def create?
    !user.nil?
  end

  def update?
    !user.nil?
  end

end

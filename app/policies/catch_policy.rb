class CatchPolicy < ApplicationPolicy
  def create?
    user.present?
  end

  def update?
    user.present?
  end
end

class CompetitionPolicy < ApplicationPolicy
  def create?
    user.present? && user.admin?
  end

  def update?
    (user.present? && user.admin?) && record.active?
  end

  def destroy?
    user.present? && user.admin?
  end

  def suspend?
    user.present? && user.admin?
  end
end

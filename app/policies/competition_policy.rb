class CompetitionPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def new?
    create?
  end

  def create?
    user.present?
  end

  def update?
    user.present?
  end

  def destroy?
    user.present? && user.role == 'administrator'
  end
end

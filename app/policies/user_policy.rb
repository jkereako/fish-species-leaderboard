class UserPolicy < ApplicationPolicy
  def index?
    user.present? && user.admin?
  end

  def show?
    user.present? && user.admin?
  end

  # Ensure only admins can toggle the user's activation record and ensure that
  # that an admin can't disable his own account.
  def toggle_activation?
    user.present? && user.admin? && (user != record)
  end
end

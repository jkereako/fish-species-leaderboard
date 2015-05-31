class UserPolicy < ApplicationPolicy
  def index?
    user.present? && user.admin?
  end

  # Allow users to view their own account but no others. Admins can view any
  # account
  def show?
    user.present? && (user.admin? || user == record)
  end

  # Disallow admins from changing passwords.
  def change_password?
    user.present? && user == record
  end

  # Ensure only admins can toggle the user's activation record and ensure that
  # that an admin can't disable his own account.
  def toggle_activation?
    user.present? && user.admin? && (user != record)
  end
end

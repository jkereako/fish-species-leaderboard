class UserInvitationPolicy < ApplicationPolicy
  # Only administrators can manage user invitations
   def create?
     user.present? && user.admin?
   end

   # Invited users require rights
   def update?
     true
   end
 end

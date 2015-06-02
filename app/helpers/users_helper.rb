module UsersHelper
  def resend_user_invitation_link(user)
    return if user.accepted_or_not_invited?
    link_to 'resend invitation',
            resend_user_invitation_path(user),
            class: 'btn btn-default btn-xs',
            data: { remote: true },
            format: 'json'
  end

  # Convert status into words
  def user_identifier_in_words(user)
    return user.name if user.name.present?
    user.email
  end

  def user_status_in_words(user)
    return 'invited' if user.invited_to_sign_up?
    return 'active' if user.active?
    return 'suspended' if user.suspended?
  end

  def user_role_in_words(user)
    return 'admin' if user.admin?
    'user'
  end

  # Apply a Bootstrap label class for each status
  def bs_class_for_user_status(user)
    return 'label-warning' if user.inivited?
    return 'label-success' if user.active?
    return 'label-danger' if user.suspended?
  end

  # Apply a Bootstrap label class for each status
  def bs_class_for_user_role(user)
    return 'label-default' if user.admin?
    'label-info'
  end
end

module UsersHelper
  def bs_user_role_label_class(role)
    if role == User.administrator_role then 'label-success' else 'label-default' end
  end
end

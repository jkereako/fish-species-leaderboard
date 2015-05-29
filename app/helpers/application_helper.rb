module ApplicationHelper

  def bs_is_active_label_class(is_active)
    if is_active then 'label-success' else 'label-danger' end
  end

  def css_class_for(controller:)
    'active' if params[:controller] == controller
  end

  def bootstrap_class_for(flash_type:)
    case flash_type.to_sym
    when :success
      'alert-success'
    when :error
      'alert-danger'
    when :alert
      'alert-warning'
    when :notice
      'alert-info'
    else
      flash_type.to_s
    end
  end
end

module ApplicationHelper
  def nav_active(page)
    return 'active' if current_page?(page) || request.original_fullpath.start_with?("#{page}/")
  end

  def navbar_icon(some_condition)
    if some_condition
      content_tag(:span, '', class: 'navbar-toggler-icon')
    else
      content_tag(:span, '', class: 'fa fa-back')
    end
  end
end

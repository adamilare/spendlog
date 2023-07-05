# frozen_string_literal: true

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

  def navigation_bar
    current_path = request.path
    if params[:controller].in?(%w[spend_categories spend_transactions])

      case current_path

      when new_spend_category_path
        nav_content(root_path, 'NEW CATEGORY')

      when spend_category_spend_transactions_path # (spend_category_id: params[:spend_category_id])
        nav_content(root_path, 'TRANSACTIONS')

      when new_spend_category_spend_transaction_path # (spend_category_id: params[:spend_category_id])
        parent_path = request.referrer.presence || spend_category_path(params[:spend_category_id])
        nav_content(parent_path, 'NEW TRANSACTION')
      end

    elsif params[:controller].in?(%w[devise/sessions devise/registrations])
      case current_path
      when new_user_session_path
        nav_content('/welcome', 'LOGIN')

      when new_user_registration_path
        nav_content('/welcome', 'REGISTER')
      end
    end
  end

  def nav_content(back_link, nav_title)
    content = <<-HTML
          <a href="#{back_link}" class="fa fa-long-arrow-alt-left nav-color" aria-hidden='true'></a>
          <span class="navbar-brand fs-4 nav-color">#{nav_title}</span>
          <span class=""></span>
    HTML

    content.html_safe
  end

  def extract_parent_path(path)
    route_params = Rails.application.routes.recognize_path(path)
    parent_params = route_params.slice(:controller, :action, :spend_category_id)

    url_for(parent_params)
  end

  def log_to_console(message)
    javascript_tag "console.log('#{message}')"
  end
end

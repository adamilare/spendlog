module ApplicationHelper
  def nav_active(page)
    return 'active' if current_page?(page) || request.original_fullpath.start_with?("#{page}/")
  end

  def submit_form(form_id, button_id)
    javascript_tag do
      <<~JS
        document.getElementById('#{button_id}').addEventListener('click', function() {
          document.getElementById('#{form_id}').submit();
        });
      JS
    end
  end

  def navigation_bar
    current_path = request.path

    if params[:controller].in?(%w[spend_categories spend_transactions])
      navigation_for_cat_trx(current_path)

    elsif params[:controller].in?(%w[devise/sessions devise/registrations devise/passwords])
      navigation_for_users(current_path)
    end
  end

  def navigation_for_cat_trx(current_path)
    case current_path

    when new_spend_category_path, spend_categories_path
      # nav_content(root_path, 'NEW CATEGORY', 'Save', 'category-action') if new_spend_category_path || request.post?
      nav_for_cat_form

    when spend_category_spend_transactions_path # (spend_category_id: params[:spend_category_id])
      return nav_content(root_path, 'TRANSACTIONS') if request.get?

      nav_for_new_transaction if request.post?

    when new_spend_category_spend_transaction_path # (spend_category_id: params[:spend_category_id])
      nav_for_new_transaction
    end
  end

  def navigation_for_users(path)
    case path
    when new_user_session_path
      nav_content('/welcome', 'LOGIN', 'Log in', 'login-action')

    when new_user_registration_path, '/users'
      nav_content('/welcome', 'REGISTER', 'Next', 'signup-action')

    when '/users/password/new'
      nav_content('/welcome', 'RESET PASSWORD', 'Reset', 'reset-action')
    end
  end

  def nav_for_cat_form
    nav_content(root_path, 'NEW CATEGORY', 'Save', 'category-action') if new_spend_category_path || request.post?
  end

  def nav_for_new_transaction
    parent_path = request.referrer.presence || spend_category_path(params[:spend_category_id])
    nav_content(parent_path, 'NEW TRANSACTION', 'Save', 'transaction-action')
  end

  def nav_content(back_link, nav_title, rigth_text = '', form_id = '')
    content = <<-HTML
          <a href="#{back_link}" class="fa fa-long-arrow-alt-left nav-color" aria-hidden='true'></a>
          <span class="navbar-brand fs-4 nav-color">#{nav_title}</span>
          #{right_element(form_id, rigth_text)}
    HTML

    content.html_safe
  end

  def right_element(rigth_id, text)
    if text
      <<-HTML
        <a class='action-trigger nav-color' id="#{rigth_id}">#{text}</a>
      HTML
    else
      <<-HTML
        <span></span>
      HTML
    end
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

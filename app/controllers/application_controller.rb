class ApplicationController < ActionController::API
  include Pundit

  attr_accessor :current_user

  rescue_from Pundit::NotAuthorizedError, with: :deny_access
  
  def authenticate_user!
   token, options = ActionController::HttpAuthentication::Token.token_and_options(request)

    user_email = options.blank??nil:options[:email]
    user = user_email && User.find_by(email: user_email)

    if user && ActiveSupport::SecurityUtils.secure_compare(user.authentication_token,token)
      self.current_user = user
    else
      return unauthenticated!
    end
  end

  def unauthenticated!
    api_error(status: 401)
  end

  def api_error(opts = {})
    render head: :unauthorized, status: opts[:status]
  end

  def deny_access
    api_error(status: 403)
  end

  def paginate_meta(resource)
  {
    current_page: resource.current_page,
    next_page: resource.next_page,
    prev_page: resource.prev_page,
    total_pages: resource.total_pages,
    total_count: resource.total_count
  }
  end

  def paginate(resource)
   resource = resource.page(params[:page] || 1)
   if params[:per_page]
     resource = resource.per(params[:per_page])
   end
   return resource
  end
end

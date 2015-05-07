class ForwardController < ActionController::Base
  def store_redirect
    allow_cross_domain_requests

    cookies[:will_redirect_to] = params[:redirect_url]

    render nothing: true
  end

  def redirect
    redirect_url = cookies[:will_redirect_to]
    if redirect_url.nil?
      render text: "No `will_redirect_to` cookie was supplied!",
             status: :bad_request
    else
      uri = URI(redirect_url)
      uri.query = request.query_parameters.to_query
      redirect_to uri.to_s
    end
  end

  private

  def allow_cross_domain_requests
    headers["Access-Control-Allow-Origin"] = "*"
    headers["Access-Control-Request-Method"] = "*"
  end
end

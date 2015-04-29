class ForwardController < ActionController::Base
  def store_redirect
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
end

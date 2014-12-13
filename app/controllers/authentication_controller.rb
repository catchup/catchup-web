class AuthenticationController < ApplicationController
  def logout
    flash[:will_logout] = true

    redirect_to root_url
  end
end

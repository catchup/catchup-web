class WelcomeController < ApplicationController
  skip_before_action :authenticate
  skip_before_action :require_invitation

  def index
    beta_user! if ENV["INVITATION_CODES"].include?(params[:invitation_code])
  end
end

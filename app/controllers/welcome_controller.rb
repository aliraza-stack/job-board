class WelcomeController < ApplicationController
  before_action :redirect_logged_in_user, only: [:index]

  def index
  end
end

class Admin::DashboardController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin
  # load_and_authorize_resource
  def index
  end

  def authorize_admin
    redirect_to after_sign_in_path_for(current_user), alert: 'Not authorized' unless current_user.admin?
  end
end

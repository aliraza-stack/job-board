class ApplicationController < ActionController::Base
    protect_from_forgery
    # before_action :redirect_logged_in_user, only: [:index]
    before_action :check_profile_completion
    rescue_from ActiveRecord::RecordNotFound, with: :route_not_found

    def after_sign_in_path_for(resource)
        if resource.admin?
            admin_dashboard_path
        elsif resource.employer?
            employer_dashboard_path
        elsif resource.freelancer?
            freelancer_dashboard_path
        else
            root_path
        end
    end

    # Action to handle not found routes
    def route_not_found
        if user_signed_in?
            redirect_to after_sign_in_path_for(current_user)
        else
            redirect_to root_path, alert: 'Page not found'
        end
    end


    private

    def redirect_logged_in_user
        if user_signed_in? && request.path == root_path
            redirect_to after_sign_in_path_for(current_user)
        end
    end

    def check_profile_completion
        if current_user &&!current_user.profile_complete? && request.path != edit_user_registration_path
            redirect_to edit_user_registration_path, alert: 'Please complete your profile before proceeding'
        end
    end

end

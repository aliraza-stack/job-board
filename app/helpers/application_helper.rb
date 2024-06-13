module ApplicationHelper

  def full_name
    if current_user.user_detail.present? && current_user.user_detail.first_name.present? && current_user.user_detail.last_name.present?
      "#{current_user.user_detail.first_name} #{current_user.user_detail.last_name}"
    else
      current_user.email.split('@').first.capitalize
    end
  end
end

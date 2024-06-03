class UserDetailsController < ApplicationController
  # before_action :set_user_detail, only: [:edit, :update]

  # def edit
  # end

  # def update
  #   respond_to do |format|
  #     if @user_detail.update(user_detail_params)
  #       format.html { redirect_to root_path, notice: 'User detail was successfully updated.' }
  #     else
  #       format.html { render :edit }
  #     end
  #   end
  # end

  # private

  # def set_user_detail
  #   @user_detail = current_user.user_detail || current_user.build_user_detail
  # end

  # def user_detail_params
  #   params.require(:user_detail).permit(:first_name, :last_name, :profession, :bio, :birthday, :gender, :phone_number, :website)
  # end
end

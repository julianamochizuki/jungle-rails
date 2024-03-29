class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      @user.errors.full_messages.each do |error|
        flash[:error] ||= []
        flash[:error] << error
      end
      redirect_to new_user_path
    end 
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end

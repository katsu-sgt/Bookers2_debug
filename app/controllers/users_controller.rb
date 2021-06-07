class UsersController < ApplicationController
  before_action :ensure_correct_user, only: [:update, :edit]

  def show
    @user = User.find(params[:id])
    @books = @user.books
    @book = Book.new
    @today_books = Book.where(created_at: Date.today.all_day).where(user_id: @user.id)
    @yesterday_books = Book.where(created_at: Date.yesterday.all_day).where(user_id: @user.id)
    @this_week_books = Book.where(created_at: Date.today.all_week).where(user_id: @user.id)
    @last_week_books = Book.where(created_at: Date.today.ago(7.days).all_week).where(user_id: @user.id)
  end

  def index
    @users = User.all
    @book = Book.new

  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user), notice: "You have updated user successfully."
    else
      render "users/edit"
    end
  end

  

  private
  def user_params
    params.require(:user).permit(:name, :introduction, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end

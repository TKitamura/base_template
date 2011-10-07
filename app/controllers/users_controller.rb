class UsersController < ApplicationController
  before_filter :authenticate, :only =>[:index,:edit, :update,:destroy]
  before_filter :correct_user, :only =>[:edit, :update]
  before_filter :admin_user, :only => :destroy

  def new
    @title = "Sign up"
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @title = @user.name
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] ="Welcome to the Sample App!"
      redirect_to @user 
    else
      @title ="Sign up"
      render "new"
    end
  end

  def edit 
   @title = "Edit user"
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      @title = "Edit user"
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] ="User destroyed"
    redirect_to users_path
  end

  private


end

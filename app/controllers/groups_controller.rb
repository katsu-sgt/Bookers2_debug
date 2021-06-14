class GroupsController < ApplicationController
  
  def index
    @groups = Group.all
    @book = Book.new
  end
  
  def show  
    @book = Book.new
    @group = Group.find(params[:id])
  end 
  
  def join
    @group = Group.find(params[:group_id])
    @group.users << current_user
    redirect_to groups_path
  end 
  
  def new
    @group = Group.new
  end 
  
  def create
    @group = Group.new(group_params)
    @group.owner_id = current_user.id
     if @group.save
       redirect_to groups_path
     else
       render 'new'
     end
  end
  
  
  
  def edit
    @group = Group.find(params[:id])
  end
  
  def update
    group = Group.find(params[:id])
    group.update(group_params)
    redirect_to groups_path
  end
  
  
  private
  
  def group_params
    params.require(:group).permit(:name, :introduction, :image)
  end 
end

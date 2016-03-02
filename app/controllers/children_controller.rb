class ChildrenController < ApplicationController

  def index   # view *all* children
    render json: Child.all
  end

  def show    # view *one* child
    render json: Child.find(params[:id])
  end

  def create
    child = Child.create(child_params)
    if child.save
      render json: child
    else
      render json: child.errors, status: :unprocessable_entity
    end
  end

  def update
    child = Child.find(params[:id])
    if child.update(child_params)
      child.save
      render json: child
    else
      render json: child.errors, status: :unprocessable_entity
    end
  end

  def destroy
    child = Child.find(params[:id])
    child.destroy
  end

  private
  def child_params
    params.require(:child).permit(:name, :parent_id)
  end

end

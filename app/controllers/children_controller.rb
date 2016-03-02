class ChildrenController < ApplicationController

  def index     # GET, view *all* children
    render json: Child.all.as_json(only: [:id, :name], include: [:parent])
  end

  def show      # GET, view *one* child
    render json: Child.find(params[:id]).as_json(only: [:id, :name], include: [:parent])
  end

  def create    # POST
    child = Child.create(child_params)
    if child.save
      render json: child, status: :created
    else
      render json: child.errors, status: :unprocessable_entity
    end
  end

  def update    # PATCH
    child = Child.find(params[:id])
    if child.update(child_params)
      child.save
      render json: child
    else
      render json: child.errors, status: :unprocessable_entity
    end
  end

  private
  def child_params
    params.require(:child).permit(:name, :parent_id)
  end

end

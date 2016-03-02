class ParentsController < ApplicationController

  def index   # view *all* parents
    render json: Parent.all
  end

  def show    # view *one* parent
    render json: Parent.find(params[:id])
  end

  def create
    parent = Parent.create(parent_params)
    if parent.save
      render json: parent
    else
      render json: parent.errors, status: :unprocessable_entity
    end
  end

  def update
    parent = Parent.find(params[:id])
    if parent.update(parent_params)
      parent.save
      render json: parent
    else
      render json: parent.errors, status: :unprocessable_entity
    end
  end

  def destroy
    parent = Parent.find(params[:id])
    parent.destroy
  end

  private
  def parent_params
    params.require(:parent).permit(:name)
  end

end

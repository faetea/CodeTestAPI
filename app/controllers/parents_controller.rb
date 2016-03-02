class ParentsController < ApplicationController

  def index    # GET, *all* parents
    render json: Parent.all.as_json(include: [:children])
  end

  def show     # GET, *one* parent
    render json: Parent.find(params[:id]).as_json(include: [:children])
  end

  def created  # POST
    parent = Parent.create(parent_params)
    if parent.save
      render json: parent, status: :created, location: parent
    else
      render json: parent.errors, status: :unprocessable_entity
    end
  end

  def update   # PATCH
    parent = Parent.find(params[:id])
    if parent.update(parent_params)
      parent.save
      render json: parent
    else
      render json: parent.errors, status: :unprocessable_entity
    end
  end

  private
  def parent_params
    params.require(:parent).permit(:name)
  end

end

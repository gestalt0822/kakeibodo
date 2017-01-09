class SortsController < ApplicationController
  def index
    @sorts = Sort.all
  end

  def new
    @sort = Sort.new
  end

  def create
    @sort = Sort.create(sorts_params)
    redirect_to sorts_path
  end

  def edit
    @sort = Sort.find(params[:id])
  end

  def update
    @sort = Sort.find(params[:id])
    @sort.update(sorts_params)
    redirect_to sorts_path
  end

  private
   def sorts_params
     params.require(:sort).permit(:name, :category_id)
   end
end

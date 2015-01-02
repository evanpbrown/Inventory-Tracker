class CategoryController < ApplicationController

  def create
    @category = Category.new(params[:category])
    if @category.save
        flash[:notice] = "Your category was created"
    else
        flash[:alert] = "There was an error creating your category."
    end
    redirect_to(category_part_url(@category))
  end

  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to(root_url) }
    end
  end
end

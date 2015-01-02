class PartsController < ApplicationController
  def index
    @todo   = Task.where(:done => false)
    @part   = Task.new
    @categories  = Category.all
    @category   = Category.new

    respond_to do |format|
      format.html
      format.json do
        render :json => {:parts => Task.all.map(&:to_json) }
      end
    end
  end

  def create
    @category = Category.find(params[:category_id])
    part_params = params[:part].is_a?(String) ? JSON.parse(params[:part]) : params[:part]
    @part = @category.parts.new(part_params)
    if @part.save
      status = "success"
      flash[:notice] = "Your part was created."
    else
      status = "failure"
      flash[:alert] = "There was an error creating your part."
    end
    respond_to do |format|
      format.html do
        redirect_to(category_parts_url(@category))
      end
      format.json do
        render :json => {:status => status, :part => @part.to_json}
      end
    end
  end

  def update
    @category = Category.find(params[:category_id])
    @part = @category.parts.find(params[:id])

    respond_to do |format|
      if @part.update_attributes(params[:part])
        format.html { redirect_to( category_parts_url(@category), :notice => 'Task was successfully updated.') }
      else
        format.html { render :action => "edit" }
      end
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    @part = Task.find(params[:id])
    @part.destroy

    respond_to do |format|
      format.html { redirect_to(category_parts_url(@category)) }
    end
  end
end

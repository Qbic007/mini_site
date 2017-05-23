class PagesController < ApplicationController

  def index
    @tree = Page.hash_tree
  end

  def show
    @page = Page.find_by_name(params[:name])
    @tree = @page.hash_tree
  end

  def new
    @page = Page.new
  end

  def edit
    @page = Page.find_by_name(params[:name])
  end

  def create
    @page = Page.new(page_params)
    if @page.validate
      if params[:name]
        @parent = Page.find_by_name(params[:name])
        @page.name = @parent.name + "/" + @page.name
        @parent.children << @page
      else
        Page.create(page_params)
      end
      redirect_to action: "show", name: @page.name
    else
      render action: 'new'
    end
  end

  def update
    @page = Page.find(params[:page][:id])
    if @page.update(page_params)
      redirect_to action: "show", name: @page.name
    else
      render action: "edit"
    end
  end

  def destroy
    @page = Page.find_by_name(params[:name])
    @page.destroy
    redirect_to action: "index"
  end

  private

  def page_params
    params.require(:page).permit(:name, :title, :content)
  end

end

# coding: utf-8
class PagesController < ApplicationController
  before_action  :get_last_one_from_url
  before_action  :get_all_perents , only: [:show]

  def index
    @pages = Page.where(parent_id: nil)
  end
  
  def show
    @page =  @last_one
  end
  
  def new
	@page = Page.new()
    @page.parent = @last_one
  end
  
  def edit
    @page = @last_one
  end
  
  def create
    @page = Page.new(pages_params)

	 if @page.save
      redirect_to URI.encode(@page.get_full_path)
    else
      redirect_to '/'
    end
  end

  def update
     @page = @last_one
    if @page.update_attributes(pages_params)
       redirect_to URI.encode(@page.get_full_path)
    else
      redirect_to '/'
    end
  end
private
  def pages_params
    params.require(:page).permit(:name, :label, :text_prime, :path, :parent_id , :text_convert  )
  end
  
  def get_last_one_from_url
    if params[:path]
    @last_one = nil
    for name in params[:path].split("/")
        @last_one = Page.where(name: name).where(
        if @last_one == nil
            parent_id = nil
        else
            parent_id = @last_one.id
        end
        ).first
    @last_one
    end
    end
    @c=[]
  end

  def get_all_perents(object = @last_one )
    if object
        @c.push(object.parent_id)
        parent = object.parent
        if parent
            get_all_perents(object = parent)
        end
    end
    @c.reject! { |c| c.nil? }
    @parents = Page.where("id IN (?)" ,@c)
   end
end

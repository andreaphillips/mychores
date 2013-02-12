class PagesController < ApplicationController
  def index
    @pages = Page.all
  end

  def show
    @page = Page.find(params[:id])
  end

  def new
    @page = Page.new(:name => 'Message Title', :content => "<div style='width:1024px;height:768px'>Message Content</div>")
    @page.save
    redirect_to(page_path(@page.id))
  end

  def update
    page = Page.find(params[:id])
    page.name = params[:content][:page_name][:value]
    page.content = params[:content][:page_content][:value]
    page.save!
    render text: ""
  end


end
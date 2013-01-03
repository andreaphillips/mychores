class KidsController < ApplicationController
  # GET /kids
  # GET /kids.json
  def index
    @kids = Kid.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @kids }
    end
  end

  # GET /kids/1
  # GET /kids/1.json
  def show
    @kid = Kid.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @kid }
    end
  end

  # GET /kids/new
  # GET /kids/new.json
  def new
    @kid = Kid.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @kid }
    end
  end

  # GET /kids/1/edit
  def edit
    @kid = Kid.find(params[:id])
  end

  # POST /kids
  # POST /kids.json
  def create
    @kid = Kid.new(params[:kid])


    if @kid.save
      render json: @kid
    else
      render json: @kid.errors, status: :unprocessable_entity
    end
  end

  # PUT /kids/1
  # PUT /kids/1.json
  def update
    @kid = Kid.find(params[:id])

    if @kid.update_attributes(params[:kid])
      render json: @kid
    else
      render json: @kid.errors, status: :unprocessable_entity
    end
  end

  # DELETE /kids/1
  # DELETE /kids/1.json
  def destroy
    @kid = Kid.find(params[:id])
    @kid.destroy

    render json: "deleted"
  end
end

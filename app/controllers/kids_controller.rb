class KidsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

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
    @user = User.find(params[:kid].delete(:user_id))
    @kid = Kid.new(params[:kid])

    @kid.user = @user


    if @kid.save
      render json: @kid
    else
      render json: @kid.errors, status: :unprocessable_entity
    end
  end

  # PUT /kids/1
  # PUT /kids/1.json
  def update
    if params[:kid][:id]
      @kid = Kid.find(params[:kid][:id])
    else
      @kid = Kid.find_by_user_id_and_local_id(params[:kid][:user_id],params[:kid][:local_id])
    end
    params[:kid].delete(:user_id)
    params[:kid].delete(:id)
    if @kid.update_attributes(params[:kid])
      render json: @kid
    else
      render json: @kid.errors, status: :unprocessable_entity
    end
  end


  # DELETE /kids/1
  # DELETE /kids/1.json
  def destroy
    @kid = Kid.find_by_user_id_and_local_id(params[:user_id],params[:id])
    if @kid
      @kid.destroy
    end

    render json: "deleted"
  end

  def thumbnail
    @kid = Kid.find(params[:id])
    send_data @kid.picture, :type => 'image/png',:disposition => "inline"
  end

  def update_chore_connection
    params[:data].each do |c|
      @user = User.find(c['user_id'])
      @kid = @user.kids.where(:local_id => c['local_kid']).first
      exists = ChoreKid.where(:kid_id => @kid.id,:chore_id => c['local_chore_id'], :begin => c['begin_date'], :end => c['end_date'])
      if exists.empty?
        ChoreKid.create(:kid_id => @kid.id,:chore_id => c['local_chore_id'], :begin => c['begin_date'], :end => c['end_date'])
      end
    end
    render :json => {'status'=> :updated}
  end

  def delete_chore_connection
    c = params[:data]
    user = User.find(c[:user_id])
    kid = user.kids.where(:local_id => c[:local_kid_id]).first
    exists = ChoreKid.where(:kid_id => kid.id,:chore_id => c['chore_id'], :begin => c['begin'], :end => c['end'])
    kid.points.where(:chore_id => c[:chore_id] , :date =>c[:begin]..c[:end] ).delete_all

    if !exists.empty?
      exists.delete_all()
    end
    render :json => {'status'=> :updated}

  end
end

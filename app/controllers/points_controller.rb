class PointsController < ApplicationController
  skip_before_filter  :verify_authenticity_token

  def index
    @points = params[:kid_id]? Point.find_all_by_kid_id(params[:kid_id]): Point.all()

  end

  def create
    @kid = Kid.find_by_user_id_and_local_id(params[:point][:user_id],params[:point][:kid_id])
    params[:point].delete(:kid_id)
    params[:point].delete(:user_id)
    @point = Point.new(params[:point])
    @point.kid = @kid
    @point.user_id = @kid.user.id

    if @point.save
      render json: @point
    else
      render json: @point.errors, status: :unprocessable_entity
    end
  end

  def show
    @points = Point.find_all_by_kid_id_and_date(params[:k_id],params[:date])

    if @points
      render json: @points
    else
      render json: @points.errors, status: :unprocessable_entity
    end

  end

  def delete
    @point = Point.find_by_kid_id_and_user_id_and_date_and_chore_id(params[:kid_id],params[:user_id],params[:date],params[:chore_id])
    @point.destroy

    render json: "deleted"
  end

  def update
    @kid = Kid.find_by_user_id_and_local_id(params[:user_id],params[:kid_id])

    @point = Point.find_by_kid_id_and_date_and_chore_id(@kid.id,params[:date],params[:chore_id])

      if @point.update_attributes(params[:point])
        render json: @point
      else
        render json: @point.errors, status: :unprocessable_entity
      end
  end
end

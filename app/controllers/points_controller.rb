class PointsController < ApplicationController
  skip_before_filter  :verify_authenticity_token
  def create
    @point = Point.new(params[:point])

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
    @point = Point.find_by_kid_id_and_parent_id_and_date_and_chore_id(params[:kid_id],params[:parent_id],params[:date],params[:chore_id])
    @point.destroy

    render json: "deleted"
  end

  def update
    @point = Point.find_by_kid_id_and_parent_id_and_date_and_chore_id(params[:kid_id],params[:parent_id],params[:date],params[:chore_id])

      if @point.update_attributes(params[:point])
        render json: @point
      else
        render json: @point.errors, status: :unprocessable_entity
      end
  end
end

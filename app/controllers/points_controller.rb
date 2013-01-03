class PointsController < ApplicationController
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
    @point = Point.find(params[:id])
    @point.destroy

    render json: "deleted"
  end

  def update
    @point = Point.find(params[:id])

      if @point.update_attributes(params[:point])
        render json: @point
      else
        render json: @point.errors, status: :unprocessable_entity
      end
  end
end

class PointsController < ApplicationController
  def create
    @point = Point.new(params[:point])

    if @point.save
      format.json { render json: @point}
    else
      format.json { render json: @point.errors, status: :unprocessable_entity }
    end
  end

  def show
    @points = Point.find_all_by_kid_id_and_date(params[:k_id],params[:date])

    if @points
      format.json { render json: @points}
    else
      format.json { render json: @points.errors, status: :unprocessable_entity }
    end

  end

  def delete
    @point = Point.find(params[:id])
    @point.destroy

    respond_to do |format|
      format.html { redirect_to kids_url }
      format.json { render json: "deleted" }
    end
  end

  def update
    @point = Point.find(params[:id])

    respond_to do |format|
      if @point.update_attributes(params[:point])
        format.json { render json: @point }
      else
        format.json { render json: @point.errors, status: :unprocessable_entity }
      end
    end
  end
end

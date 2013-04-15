class RewardsController < ApplicationController
  def create
    @kid = Kid.find_by_user_id_and_local_id(params[:reward][:user_id],params[:reward][:kid_id])
    params[:reward].delete(:kid_id)
    params[:reward].delete(:user_id)
    @reward = Reward.new(params[:reward])
    @reward.kid = @kid

    if @reward.save
      render json: @reward
    else
      render json: @reward.errors, status: :unprocessable_entity
    end
  end

  def update
    @kid = Kid.find_by_user_id_and_local_id(params[:reward][:user_id],params[:reward][:kid_id])

    @reward = Reward.find_or_create_by_kid_id_and_begin_and_end(@kid.id,params[:reward][:begin],params[:reward][:end])

    if @reward.update_attribute('reward',params[:reward][:reward])
      render json: @reward
    else
      render json: @reward.errors, status: :unprocessable_entity
    end
  end
end

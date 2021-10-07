class MyBikesController < ApplicationController
  def new
    @my_bike = MyBike.new
  end

  def create
    @my_bike = MyBike.new(my_bike_params)
    @my_bike.user_id = current_user.id
    if @my_bike.save
      flash[:notice] = "マイバイクの保存が完了しました"
      redirect_to user_path(current_user)
    else
      flash[:alert] = "マイバイクの作成に失敗しました"
      render :new
    end
  end

  def edit
    @my_bike = MyBike.find(params[:id])
    unless @my_bike.user_id == current_user.id
      flash[:alert] = "他の方のマイバイクは編集できません"
      redirect_to user_path(current_user.id)
    end
  end

  def update
    @my_bike = MyBike.find(params[:id])
    if @my_bike.update(my_bike_params)
      flash[:notice] = "マイバイクの編集が完了しました"
      redirect_to user_path(current_user.id)
    else
      flash[:alret] = "マイバイクの編集に失敗しました"
      redirect_to = user_path(current_user.id)
    end
  end

  def destroy
  end

  private

  def my_bike_params
    params.require(:my_bike).permit(:name, :picture, :purchase_date, :description, :user_id, :remove_picture)
  end
end

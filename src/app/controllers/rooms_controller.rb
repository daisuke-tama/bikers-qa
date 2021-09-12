class RoomsController < ApplicationController
  before_action :authenticate_user!

  def show
    @room = Room.find(params[:id])
    if Entry.where(user_id: current_user.id, room_id: @room.id).present?
      @messages = @room.messages
      @message = Message.new
      @entries = @room.entries
    else
      redirect_to root_path
      flash[:alert] = "あなたはこのダイレクトメッセージルームのメンバーではありません"
    end
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      @entry1 = Entry.create(room_id: @room.id, user_id: current_user.id)
      @entry2 = Entry.create(entry_params)
      redirect_to "/rooms/#{@room.id}"
      flash[:notice] = "ルームの作成が完了しました"
    else
      redirect_to request.referer
      flash[:alert] = "ルームの名前は必須です"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to root_path
    flash[:notice] = "ダイレクトメッセージルームを削除しました"
  end

  private

  def room_params
    params.require(:room).permit(:name)
  end

  def entry_params
    params.require(:entry).permit(:user_id, :room_id).merge(room_id: @room.id)
  end
end

class MessagesController < ApplicationController
  before_action :authenticate_user!, :only => [:create]

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(message_params)
      if @message.save
        flash[:notice] = "メッセージを送信しました"
      else
        flash[:alert] = "メッセージの送信に失敗しました"
      end
      redirect_to "/rooms/#{@message.room_id}"
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @message = Message.find(params[:id])
    @message.destroy
    redirect_to request.referer
  end

  private

  def message_params
    params.require(:message).permit(:user_id, :content, :room_id).merge(user_id: current_user.id)
  end
end

class MessagesController < ApplicationController
  before_action :authenticate_user!

  def create
    if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
      @message = Message.new(message_params)
      @room = @message.room
      if @message.save
        temp_ids = Entry.where(room_id: @room.id).where.not(user_id: current_user.id)
        @theid=temp_ids.find_by(room_id: @room.id)
        notification = current_user.active_notifications.new(
          message_id: @message.id,
          entry_id: @room.id,
          visitor_id: current_user.id,
          visited_id: @theid.user_id,
          action: 'message'
        )
        if notification.visitor_id == notification.visited_id
          notification.checked = true
        end
        notification.save if notification.valid?
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

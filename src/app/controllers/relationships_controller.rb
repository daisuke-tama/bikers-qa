class RelationshipsController < ApplicationController
  def create
    @user = User.find(params[:user_id]) # views/relationships/create.js.erbへ送るため
    follow = current_user.active_relationships.build(follower_id: params[:user_id])
    follow.save
  end

  def destroy
    @user = User.find(params[:user_id]) # views/relationships/destroy.js.erbへ送るため
    follow = current_user.active_relationships.find_by(follower_id: params[:user_id])
    follow.destroy
  end
end

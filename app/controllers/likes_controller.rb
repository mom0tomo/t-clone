class LikesController < ApplicationController
  before_action :require_user_logged_in

  def create
    post = Post.find(params[:post_id])
    current_user.like(post)
    flash[:success] = '投稿をlikeしました'
    redirect_back(fallback_location: root_url)
  end

  def destroy
    post = Post.find(params[:post_id])
    current_user.unlike(post)
    flash[:success] = '投稿のlikeを解除しました'
    redirect_back(fallback_location: root_url)
  end
end

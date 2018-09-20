class TopsController < ApplicationController
  def index
    if logged_in?
      # 空のインスタンス。form_for(@micropost) として使う
      @post = current_user.posts.build
      @posts = current_user.timeline_posts.order('created_at DESC').page(params[:page])
    end
  end
end

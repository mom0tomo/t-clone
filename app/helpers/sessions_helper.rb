module SessionsHelper

  # @current_user現在のログインユーザが代入されていたら何もしない, 代入されていなかったらUser.find(...)でログインユーザを取得する
  def current_user
    # 見つからない場合にはエラーを発生させずにnilを返す
    @current_user ||= User.find_by(id: session[:user_id])
  end

  # ログインしていればtrue, ログインしていなければfalseを返す
  def logged_in?
    !!current_user
  end
end

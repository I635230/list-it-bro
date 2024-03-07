class UsersController < ApplicationController
  # TODO: Authenticationsの中でユーザー作成やってるけど、ちゃんとこっちのアクションにつなげた方が良いのか？

  def index
    render status: :ok, json: User.all.map(&:display_name)
  end
end

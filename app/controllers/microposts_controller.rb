class MicropostsController < ApplicationController
  def index
    user = User.find(params[:user_id])
    #使用分页函数
    @microposts = paginate(user.microposts)
    #添加meta数据方法
    render json: @microposts, meta: paginate_meta(@microposts)
  end
end

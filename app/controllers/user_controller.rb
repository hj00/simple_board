class UserController < ApplicationController
  def index
    @users = User.all
  end

  def new
  end

  def create
    @email = params[:email]
    @password = params[:password]
    pw = Digest::MD5.hexdigest(@password)
    
    User.create(
      email: @email,
      password: pw
    )
    
    redirect_to '/'
  end

  def show
  end
  
  def login
  end
  
  # def login_process
  #   @message = ""
  #   @email = params[:email]
  #   if User.exists?(email: @email)
  #     user = User.find_by(email: @email)
  #     if user.password == Digest::MD5.hexdigest(params[:password])
  #       session[:user_email] = user.email
  #       redirect_to '/'
  #     end
  #   end
  # end
  
  def login_process
    @user = User.find_by(email: params[:email])
    if @user
      if @user.password == Digest::MD5.hexdigest(params[:password])
        session[:user_id] = @user.id
        flash[:notice] = "로그인이 되었습니다."
        redirect_to '/'
      else
        flash[:notice] = "비밀번호가 틀렸습니다."
        redirect_to '/user/login'
      end
    end
  end
  
  def logout
    session.clear
    flash[:notice] = "로그아웃 되었습니다."
    redirect_to '/'
  end
  
end

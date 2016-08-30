class User < ActiveRecord::Base

  has_many :sessions
  has_many :blogs
  has_many :comments

  def self.login params
    return 'user not found' unless user = User.find_by(params[:email])
    return 'wrong password' unless user.password == params[:password]
    Session.generate user, params[:user_agent]
  end

  def self.regist params

  end

  def self.change_pwd params
    return 'user not found' unless user = User.find_by(params[:email])
    return 'wrong password' unless user.password == params[:password]
    user.update_attributes(password: params[:new_password])
    user.reload
  end

end

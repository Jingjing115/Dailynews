class User < ActiveRecord::Base

  has_many :sessions
  has_many :blogs
  has_many :comments

  def self.login params
    return 'user not found' unless user = User.find_by(email: params[:email])
    return 'wrong password' unless user.password == params[:password]
    Session.generate user, params[:user_agent]
  end

  def self.regist params
    return 'invalid email' unless is_a_valid_email? params[:email]
    return 'this email already exist' if User.find_by(email: params[:email])
    return 'this name already exist' if User.find_by(name: params[:name])
    User.create(email: params[:email], password: params[:password], name: params[:name])
  end

  def self.is_a_valid_email? email
    email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  end

  def self.change_pwd params
    return 'user not found' unless user = User.find_by(email:params[:email])
    return 'wrong password' unless user.password == params[:password]
    user.update_attributes(password: params[:new_password])
    user.sessions.select{|s|!s.expired?}.map(&:expired)
    user.reload
  end

end

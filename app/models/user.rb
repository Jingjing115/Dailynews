class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :sessions
  has_many :blogs
  has_many :comments
  has_many :dailies
  has_and_belongs_to_many :user_groups

  def self.login params
    return 'user not found' unless user = User.find_by(email: params[:email])
    return 'wrong password' unless user.password == Digest::MD5.hexdigest(params[:password])
    Session.generate user, params[:user_agent]
  end

  def self.find_by_auth_header auth_header
    ((session = Session.find_by(session_id: auth_header)) && !session.expired?) ? session.user : nil
  end

  def self.regist params
    return 'invalid email' unless is_a_valid_email? params[:email]
    return 'this email already exist' if User.find_by(email: params[:email])
    return 'this name already exist' if User.find_by(name: params[:name])
    User.create(email: params[:email], password: Digest::MD5.hexdigest(params[:password]), name: params[:name])
  end

  def self.is_a_valid_email? email
    email =~ /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  end

  def self.change_pwd params
    return 'user not found' unless user = User.find_by(email:params[:email])
    return 'wrong password' unless user.password == Digest::MD5.hexdigest(params[:password])
    user.update_attributes(password: Digest::MD5.hexdigest(params[:new_password]))
    user.sessions.select{|s|!s.expired?}.map(&:expired)
    user.reload
  end

  def has_perm? code
    user_groups.each do |ug|
      return true if ug.has_perm?('administrator')
      return true if ug.has_perm?(code.to_s)
    end
    false
  end

end

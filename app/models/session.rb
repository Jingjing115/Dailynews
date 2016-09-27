class Session < ActiveRecord::Base
  belongs_to :user

  def generate_session_id(secure_session = SecureRandom.hex(16))
    return secure_session if Session.find_by(session_id: secure_session).nil?
    generate_session_id
  end

  def self.generate user, user_agent
    session = Session.find_or_create_by(user_agent: user_agent, user: user)
    session.update_attributes(session_id: session.generate_session_id, expired_at: Time.now + 30.days)
    reload
  end

  def expired
    update_attributes(expired_at: Time.now)
  end

  def expired?
    expired_at == nil || expired_at < Time.now
  end
end

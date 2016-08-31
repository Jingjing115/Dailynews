class Session < ActiveRecord::Base
  belongs_to :user
  before_create :refresh

  def generate_session_id(secure_session = SecureRandom.hex(16))
    return secure_session if Session.where(session_id: secure_session).first.blank?
    generate_session_id
  end

  def self.find_by_auth_header session_id
    session = Session.find_by_session_id(session_id)
    if session && !session.expired?
      session
    else
      nil
    end
  end

  def self.generate user, user_agent
    session = Session.find_by(user_agent: user_agent, user: user)
    if session
      session.refresh
      session.save!
      session
    else
      Session.create(user: user, user_agent: user_agent)
    end
  end

  def refresh
    self.session_id = generate_session_id
    self.expired_at = Time.now + 30.days
    self
  end

  def expired
    self.update_attributes(expired_at: Time.now)
  end

  def expired?
    expired_at == nil || expired_at < Time.now
  end
end

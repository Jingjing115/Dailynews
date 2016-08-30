class Session < ActiveRecord::Base
  belongs_to :user
  before_save :generate_session_id

  def generate_session_id
    session_id = SecureRandom.hex(16)
    generate_session_id if Session.find_by_session_id(session_id)
    expired_at = Time.now + 30.days
  end

  def self.generate user, user_agent
    session = Session.find_by(user_agent: user_agent, user: user)
    if session
      session.refresh
    else
      Session.create(user: user)
    end
  end

  def refresh
    generate_session_id
    save
    reload
  end

  def expired?
    expired_at > Time.now
  end
end

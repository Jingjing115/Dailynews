class Daily < ActiveRecord::Base
  belongs_to :user
  before_save do |record|
    time = Time.now
    case spec_type
    when 2
      record.goal_info = "#{time.year}-#{time.month}"
    when 3
      record.goal_info = "#{time.year}-#{((time.month - 1) / 3) + 1}"
    when 4
      record.goal_info = "#{time.year}"
    end
  end

  validates :title, presence: true
  validates :content, presence: true

  scope :daily, -> { where(spec_type: 1) }
  scope :month_goal, -> { where(:spec_type => 2) }
  scope :quarter_goal, -> { where(:spec_type => 3) }
  scope :year_goal, -> { where(:spec_type => 4) }

end

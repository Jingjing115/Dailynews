class Permission < ActiveRecord::Base
  has_and_belongs_to_many :user_groups

  validates :name, presence: true, uniqueness: true
  validates :code, presence: true, uniqueness: true
end

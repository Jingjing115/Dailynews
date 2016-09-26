class UserGroup < ActiveRecord::Base
  has_and_belongs_to_many :users
  has_and_belongs_to_many :permissions

  validates :name, presence: true, uniqueness: true

  def has_perm? code
    permissions.exists?(code: code)
  end
end

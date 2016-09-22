class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :blog
  belongs_to :source, polymorphic: true

  has_many :replys, class_name: "Comment",foreign_key: "source_id"

  belongs_to :source, class_name: "Comment"

end

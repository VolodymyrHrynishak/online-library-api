class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :book

  validates :content, presence: true

  def self.ransackable_attributes(auth_object = nil)
    [ "book_id", "content", "created_at", "id", "updated_at", "user_id" ]
  end

  def self.ransackable_associations(auth_object = nil)
    [ "book", "user" ]
  end
end

class User < ApplicationRecord
  has_many :comments
  has_many :books, through: :comments

  validates :name, :email, presence: true

  def self.ransackable_associations(auth_object = nil)
    [ "comments", "books" ]
  end

  def self.ransackable_attributes(auth_object = nil)
    [ "id", "name", "email", "created_at", "updated_at" ]
  end
end

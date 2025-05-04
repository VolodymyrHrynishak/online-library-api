class Book < ApplicationRecord
    has_many :comments
    has_many :users, through: :comments

    validates :title, :author, presence: true

    def self.ransackable_associations(auth_object = nil)
        [ "comments", "users" ]
    end

    def self.ransackable_attributes(auth_object = nil)
        [ "author", "created_at", "description", "id", "title", "updated_at" ]
    end
end

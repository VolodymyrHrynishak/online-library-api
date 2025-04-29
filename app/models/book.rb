class Book < ApplicationRecord
    has_many :comments
    has_many :users, through: :comments


    validates :title, :author, presence: true
end

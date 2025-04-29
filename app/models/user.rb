class User < ApplicationRecord
    has_many :comments
    has_many :books, through: :comments


validates :name, :email, presence: true
end

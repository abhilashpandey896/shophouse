class Product < ApplicationRecord
    has_one_attached :image
    belongs_to :user
    has_many :reviews, dependent: :destroy
    has_many :carts
end

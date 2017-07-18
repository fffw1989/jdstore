class Product < ApplicationRecord
  # mount_uploader :image, ImageUploader
  # belongs_to :category
  #
  #  has_many :photos
  #  accepts_nested_attributes_for :photos
  #  has_many :cart_items, dependent: :destroy

  mount_uploader :image, ImageUploader

  has_many :photos
  accepts_nested_attributes_for :photos

  has_many :comments

  belongs_to :category, :optional => true

  has_many :product_details
  accepts_nested_attributes_for :product_details

  has_many :cart_items, dependent: :destroy            #当商品删除时，同时删除对应购物车格子里的记录 cart_item

  has_many :carts, through: :cart_items, source: :cart

end

class Recipe < ApplicationRecord
  has_many :ingredients, dependent: :destroy
  has_many :directions, dependent: :destroy
  accepts_nested_attributes_for :ingredients, allow_destroy: true
  accepts_nested_attributes_for :directions,  allow_destroy: true
  validates :title,:description, :image, presence: true
  # validates_associated :ingredients
  # validates_associated :directions
  has_attached_file :image, styles: { medium: "200x200#"}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end

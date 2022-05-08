class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorited_posts, through: :favorites, source: :post

  has_one_attached :profile_image

  def get_profile_image(width, height)
    unless profile_image.attached?
      file_path = Rails.root.join('app/assets/images/IMG_1.jpg')
      profile_image.attach(io: File.open(file_path), filename: 'default-image', content_type: 'image/jpg')
    end
    profile_image.variant(resize_to_limit:[width, height]).processed
  end

  def full_name
    "#{self.first_name} #{self.last_name}"
  end

  #検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @customer = Customer.where(first_name: word)
    elsif search == "forward_match"
      @customer = Customer.where("first_name LIKE?", "#{word}%")
    elsif search == "backward_match"
      @customer = Customer.where("last_name LIKE?","%#{word}")
    else
      @customer = Customer.all
    end
  end

  def favorited_by?(post_id)
    favorites.where(post_id: post_id).exists?
  end
end

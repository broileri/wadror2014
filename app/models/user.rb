class User < ActiveRecord::Base
  include AverageRating

  has_secure_password

  validates :username, uniqueness: true,
                       length: { minimum: 3,
                       maximum: 15 }  
  validates :password, presence: true,
                       :format => {:with => /\A(?=.*[A-Z])(?=.*[0-9]).{3,}\z/,
                       message: "password length must be at least 3 characters and it must contain one number and one upper case letter"}
  
  has_many :ratings, dependent: :destroy
  has_many :beers, through: :ratings
  has_many :memberships, dependent: :destroy
  has_many :beer_clubs, through: :memberships

  def to_s
    "#{username}"
  end

end
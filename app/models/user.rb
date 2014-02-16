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

  def favourite_beer
    return nil if ratings.empty?
    ratings.order(score: :desc).limit(1).first.beer
  end

  def favourite_style
    return nil if ratings.empty?
    count_average(group_ratings(:style))
  end

  def favourite_brewery
    return nil if ratings.empty?
    count_average(group_ratings(:brewery))
      
  end



  private

  def count_average(favourite)
    favourite
      .map{ |fav, ratings| [fav, avg_for_ratings(ratings)] }
        .max_by { |fav, avg| avg }.first
  end

  def group_ratings(category)
    Rating.all.group_by { |b| b.beer.send(category) }
  end

  def avg_for_ratings(ratings)
    ratings.inject(0) { |sum,rating| sum + rating.score } / ratings.count
  end

end
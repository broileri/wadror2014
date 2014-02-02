class Brewery < ActiveRecord::Base

  include AverageRating
  
  has_many :beers, :dependent => :destroy
  has_many :ratings, :through => :beers

  validates :name, presence: true
  validates_numericality_of :year, { :greater_than_or_equal_to => 1042,
                                      :only_integer => true }
  validate :year_cannot_be_in_the_future
 
  def year_cannot_be_in_the_future
    if year.present? && year > Time.now.year
      errors.add(:year, "cannot be in the future!")
    end
  end

  def to_s
    "#{name}"
  end

  def print_report
    puts name
    puts "established at year #{year}"
    puts "number of beers #{beers.count}"
    puts "number of ratings #{ratings.count}"
  end

  def restart
    self.year = 2014
    puts "changed year to #{year}"
  end

end
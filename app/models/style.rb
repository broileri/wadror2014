class Style < ActiveRecord::Base
    has_many :beers

    validates :name, uniqueness: true
    validates :name, presence: true

    def to_s
      "#{name}"
    end    

    def self.top_ratings(n)
      top_ratings = []
      top_styles = top(n)
      top_styles.each do |style|
        top_ratings.push( style.beers.inject(0) {|sum, beer| sum + beer.average_rating} / (divisor(style.beers.count)) )
      end
      Hash[top_ratings.zip(top_styles)] 
    end

    private

    def self.top(n)
      # Yksittäisen tyylin keskiarvo: style.beers.inject(0) {|sum, beer| sum + beer.average_rating} / style.beers.count    
      sorted_by_rating_in_desc_order = Style.all.sort_by{ |s| -(s.beers.inject(0) {|sum, beer| sum + beer.average_rating} / (divisor(s.beers.count)) ) } 
      sorted_by_rating_in_desc_order.first(n)
    end

    def self.divisor(d)
      if d > 0
        d
      else
        1
      end 
    end
   
end
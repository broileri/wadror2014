module AverageRating

  def average_rating
  	(ratings.pluck(:score).inject { |res, el| res + el } / ratings.count.to_f).round(2)
  end
  
end
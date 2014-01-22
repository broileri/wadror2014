class Beer < ActiveRecord::Base
  belongs_to :brewery
  has_many :ratings

  def average_rating
  	# ret = 0
  	# ratings.each do |rating|
  	# 	ret = ret + rating.score
  	# end  	
  	# (ret / ratings.count.to_f).round(2)
  	(ratings.pluck(:score).inject { |res, el| res + el } / ratings.count.to_f).round(2)
  end

end

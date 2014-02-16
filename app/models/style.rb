class Style < ActiveRecord::Base
    has_many :beers

    validates :name, uniqueness: true
    validates :name, presence: true

    def to_s
      "#{name}"
    end
end
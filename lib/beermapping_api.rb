class BeermappingApi

  def self.places_in(city)
    city = city.downcase
    Rails.cache.fetch(city, :expires_in => 7.days) { fetch_places_in(city) }
  end

  private

  def self.fetch_places_in(city)
    url = "http://beermapping.com/webservice/loccity/#{key}/"

    response = HTTParty.get "#{url}#{ERB::Util.url_encode(city)}"
    places = response.parsed_response["bmp_locations"]["location"]

    return [] if places.is_a?(Hash) and places['id'].nil?

    places = [places] if places.is_a?(Hash)
    places.inject([]) do | set, place |
      set << Place.new(place)
    end
  end

  def self.fetch_place(id)
    url = "http://beermapping.com/webservice/locquery/#{key}/#{id}"
    response = HTTParty.get url
    place = response.parsed_response["bmp_locations"]["location"]

    return Place.new(place)
  end

  def self.place(id)
    Rails.cache.fetch(id, :expires_in => 7.days) { fetch_place(id) }
  end

  def self.fetch_score(id)
    url = "http://beermapping.com/webservice/locscore/#{key}/#{id}"
    response = HTTParty.get url
    score = response.parsed_response["bmp_locations"]["location"]

    return score
  end

  def self.score(id)
    score_id = id + "_score"
    Rails.cache.fetch(score_id, :expires_in => 7.days) { fetch_score(id) }
  end

  def self.key
    Settings.beermapping_apikey
  end
end
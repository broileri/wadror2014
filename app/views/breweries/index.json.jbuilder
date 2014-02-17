json.array!(@breweries) do |brewery|
  json.extract! brewery, :id, :name, :year
  json.beers do
    json.length brewery.beers.length
  end
  json.url brewery_url(brewery, format: :json)
end

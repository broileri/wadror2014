require 'spec_helper'

describe User do

  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end



  describe "when registering a user with a proper password the user..." do
    let(:user){ FactoryGirl.create(:user) }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and has the correct average rating with two ratings" do
      rating = Rating.new score:10
      rating2 = Rating.new score:20

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end



  describe "when registering a user with a password that..." do
  	let(:user){ User.new username:"Pekka" }

  	it "is too short the user is not saved" do
  		user.password = "A1"
  		user.password_confirmation = "A1"
  		user.save

  		expect(user).not_to be_valid
        expect(User.count).to eq(0)
  	end

  	it "contains only letters the user is not saved" do
  		user.password = "Trololololol"
  		user.password_confirmation = "Trololololol"
  		user.save

  		expect(user).not_to be_valid
        expect(User.count).to eq(0)
  	end
  end

  describe "'s favourite beer" do
  	let(:user){ FactoryGirl.create(:user) }

  	it "has a method for determining the favourite beer" do
      user.should respond_to :favourite_beer
    end

    it "does not exist without ratings" do
      expect(user.favourite_beer).to eq(nil)
    end

    it "is the one beer the user has rated, if the user has rated only one beer" do
      beer = create_beer_with_rating(10, user)

      expect(user.favourite_beer).to eq(beer)
    end

    it "is the one with highest rating if user has rated several beers" do
      create_beers_with_ratings(10, 20, 15, 7, 9, user)
      best = create_beer_with_rating(25, user)

      expect(user.favourite_beer).to eq(best)
    end

  end

  describe "'s favourite style" do
  	let(:user){ FactoryGirl.create(:user) }
    let!(:style1) { FactoryGirl.create :style, name:"Weizen" }
    let!(:style2) { FactoryGirl.create :style, name:"Pale Ale" }
    let!(:style3) { FactoryGirl.create :style, name:"IPA" }
    let!(:style4) { FactoryGirl.create :style, name:"APU" }
    let!(:style5) { FactoryGirl.create :style, name:"LOL" }

  	it "has a method for determining the favourite style" do
      user.should respond_to :favourite_style
    end

    it "does not exist without ratings" do
      expect(user.favourite_style).to eq(nil)
    end

    it "is the style of the one beer the user has rated, if the user has rated only one beer" do
      beer = create_beer_with_rating(10, user)

      expect(user.favourite_style).to eq(beer.style)
    end

    it "is the style with highest average rating if user has rated several beers" do
      styles = [style1, style2, style3, style4, style5]
      create_beers_with_ratings_and_styles(10, 20, 15, 7, 9, user, styles)      

      user.favourite_style.name.should == "Pale Ale"
    end

  end

  describe "'s favourite brewery" do
  	let(:user){ FactoryGirl.create(:user) }


  	it "has a method for determining the favourite brewery" do
      user.should respond_to :favourite_brewery
    end

    it "does not exist without ratings" do
      expect(user.favourite_brewery).to eq(nil)
    end

    it "is the brewery of the one beer the user has rated, if the user has rated only one beer" do
      beer = create_beer_with_rating 10, user
      expect(user.favourite_brewery).to eq(beer.brewery)
    end

    it "is the brewery with highest average rating if user has rated several beers" do
      brewery1 = Brewery.create(name:"Eka", year:1999)
      brewery2 = Brewery.create(name:"Toka", year:1977)
      brewery3 = Brewery.create(name:"Kolmas", year:1895)
      create_beers_with_ratings_and_brewery(10, 20, 15, 7, 9, user, brewery1, "liemi1")
      create_beers_with_ratings_and_brewery(11, 21, 16, 17, 29, user, brewery2, "liemi2")
      create_beers_with_ratings_and_brewery(1, 2, 1, 7, 2, user, brewery3, "liemi3")

      expect(user.favourite_brewery).to eq(brewery2)
    end

  end

  # Testien apumetodit

  
  def create_beer_with_rating(score, user)
      style = FactoryGirl.create(:style, name:"litku")
      beer = FactoryGirl.create(:beer, style:style)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
      beer
  end

  def create_beer_with_ratings_helper(score, user, style)      
      beer = FactoryGirl.create(:beer, style:style)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
      beer
  end

  def create_beers_with_ratings(*scores, user)
    style = FactoryGirl.create(:style, name:"mehu")
    scores.each do |score|
      create_beer_with_ratings_helper(score, user, style)
    end
  end

  def create_beer_with_rating_and_style(score, user, style)
      beer = FactoryGirl.create(:beer, style:style)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
      beer
  end

  def create_beers_with_ratings_and_styles(*scores, user, styles)

    scores.each do |score|
      s = styles.shift
      create_beer_with_rating_and_style(score, user, s)
    end
  end

  def create_beer_with_rating_and_brewery(score, user, brewery, style)
      beer = FactoryGirl.create(:beer, brewery:brewery, style:style)
      FactoryGirl.create(:rating, score:score, beer:beer, user:user)
      beer
  end

  def create_beers_with_ratings_and_brewery(*scores, user, brewery, st)
    style = FactoryGirl.create(:style, name:st)
    scores.each do |score|
      create_beer_with_rating_and_brewery(score, user, brewery, style)
    end
  end
end

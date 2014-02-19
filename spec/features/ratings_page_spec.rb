require 'spec_helper'
include OwnTestHelper

describe "Ratings page" do
  let!(:user) { FactoryGirl.create :user, username:"Arvostelija" }
  let!(:brewery1) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:brewery2) { FactoryGirl.create :brewery, name:"Olvi" }
  let!(:style) { FactoryGirl.create :style }
  let!(:beer1) { FactoryGirl.create :beer, name:"Iso 3", brewery:brewery1, style:style }
  let!(:beer2) { FactoryGirl.create :beer, name:"Alvi", brewery:brewery2, style:style }
  let!(:rating1) { FactoryGirl.create :rating, score:"11", beer:beer1, user:user }
  let!(:rating2) { FactoryGirl.create :rating, score:"23", beer:beer1, user:user }
  let!(:rating3) { FactoryGirl.create :rating, score:"6", beer:beer2, user:user }
  

  it "shows the ratings that are in the database" do
  	visit ratings_path
  	expect(page).to have_content "Iso 3 11"
  	expect(page).to have_content "Iso 3 23"
  	expect(page).to have_content "Alvi 6"
  end

  it "shows the number of ratings that are in the database" do
  	visit ratings_path
  	expect(page).to have_content "Number of ratings 3"
  end

end
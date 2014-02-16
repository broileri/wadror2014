require 'spec_helper'
include OwnTestHelper

describe "User page" do
  let!(:user1) { FactoryGirl.create :user }
  let!(:user2) { FactoryGirl.create :user, username:"Lupu" }
  let!(:brewery1) { FactoryGirl.create :brewery, name:"Koff" }
  let!(:brewery2) { FactoryGirl.create :brewery, name:"Olvi" }
  let!(:style) { FactoryGirl.create :style }
  let!(:style2) { FactoryGirl.create :style, name:"Pale Ale" }
  let!(:beer1) { FactoryGirl.create :beer, name:"Iso 3", style:style, brewery:brewery1 }
  let!(:beer2) { FactoryGirl.create :beer, name:"Alvi", style:style2, brewery:brewery2 }
  let!(:rating1) { FactoryGirl.create :rating, score:"11", beer:beer1, user:user1 }
  let!(:rating2) { FactoryGirl.create :rating, score:"23", beer:beer1, user:user2 }
  let!(:rating3) { FactoryGirl.create :rating, score:"6", beer:beer2, user:user1 }

  before :each do
  	sign_in(username:"Pekka", password:"Foobar1")
  end

  it "shows all ratings made by the logged in user" do  	

  	expect(page).to have_content "Pekka's ratings"
  	expect(page).to have_content "Iso 3, 11"
  	expect(page).to have_content "Alvi, 6"
  end

  it "does not show ratings made by other users" do

  	expect(page).not_to have_content "Iso 3, 23"
  end

  it "allows the logged in user to delete ratings made by him/her" do  	

  	expect{ find(:xpath, "(//a[text()='delete'])[2]").click }.to change{Rating.count}.by(-1)
  	expect(page).to have_content "Iso 3, 11"
  	expect(page).not_to have_content "Alvi, 6"
  end

  it "shows the user's favourite brewery" do
  	expect(page).to have_content "Favourite brewery: Koff"  	
  end

  it "shows the user's favourite style" do
  	expect(page).to have_content "Favourite style: Lager"   	
  end

  it "shows the user's favourite beer" do
  	expect(page).to have_content "Favourite beer: Iso 3"   	
  end

end
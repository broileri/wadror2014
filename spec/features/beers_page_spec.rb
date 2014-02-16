require 'spec_helper'

include OwnTestHelper

describe "Beers page" do
  let!(:user) { FactoryGirl.create :user }
  let!(:style) { FactoryGirl.create :style }

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end
  

  it "should allow adding a new beer to database if beer is given a proper name" do
  	visit new_beer_path
  	fill_in('beer_name', with:'Herkkuolut')

  	expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end

  it "should not allow adding a new beer to database if beer is not given a proper name" do
  	visit new_beer_path

  	expect{ click_button('Create Beer') }.to change{Beer.count}.by(0)
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "New Beer"
  end

end
require 'spec_helper'

describe "Breweries page" do
  it "should not have any breweries before some have been created" do
    visit breweries_path
    expect(page).to have_content 'Breweries'
    expect(page).to have_content 'Number of active breweries: 0'
    expect(page).to have_content 'Number of retired breweries: 0'

  end

  describe "when breweries exists" do

    before :each do
      @active_breweries = ["Koff", "Karjala", "Schlenkerla"]
      year = 1896
      @active_breweries.each do |brewery_name|
        FactoryGirl.create(:brewery, name: brewery_name, year: year += 1)
      end

      @retired_breweries = ["Kaff", "Kurjala", "Schlönkerla"]
      year = 1899
      @retired_breweries.each do |brewery_name|
        FactoryGirl.create(:brewery, name: brewery_name, year: year += 1, active:false)
      end

      visit breweries_path
    end

    it "lists the breweries and their total number" do
      expect(page).to have_content "Number of active breweries: #{@active_breweries.count}"
      expect(page).to have_content "Number of retired breweries: #{@retired_breweries.count}"
      @active_breweries.each do |brewery_name|
        expect(page).to have_content brewery_name
      end
      @retired_breweries.each do |brewery_name|
        expect(page).to have_content brewery_name
      end
    end

    it "allows user to navigate to page of a Brewery" do
      click_link "Koff"

      expect(page).to have_content "Koff"
      expect(page).to have_content "Established in 1897"
    end

  end
end
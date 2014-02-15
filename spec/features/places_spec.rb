require 'spec_helper'

describe "Places" do

  it "if one is returned by the API, it is shown on the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi") ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
  end

  it "if many are returned by the API, they are shown on the page" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return(
        [ Place.new(:name => "Oljenkorsi"),
          Place.new(:name => "Suuri Hauki"),
          Place.new(:name => "Ruutana")  ]
    )

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "Oljenkorsi"
    expect(page).to have_content "Suuri Hauki"
    expect(page).to have_content "Ruutana"
  end

  it "if none are returned by the API, the page shows an error message" do
    BeermappingApi.stub(:places_in).with("kumpula").and_return([])

    visit places_path
    fill_in('city', with: 'kumpula')
    click_button "Search"

    expect(page).to have_content "No locations in kumpula city"
  end
end
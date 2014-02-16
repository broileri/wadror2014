require 'spec_helper'

describe Beer do
	let!(:style) { FactoryGirl.create :style }

	it "is saved in the database if it has a proper name and style" do
		beer = Beer.create(name:"Limaliemi", style:style)

		expect(beer).to be_valid
		expect(Beer.count).to eq(1)
	end

	it "is not saved in the database if it does not have a name" do
		beer = Beer.create(style:style)

		expect(beer).not_to be_valid
		expect(Beer.count).to eq(0)
	end

	it "is not saved in the database if it does not have a style" do
		beer = Beer.create(name:"Limaliemi")

		expect(beer).not_to be_valid
		expect(Beer.count).to eq(0)
	end


  
end

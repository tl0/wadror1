require 'rails_helper'

RSpec.describe Beer, type: :model do
  it "created successfully if name and style" do
    beer = Beer.create name:"Testiolut", style:"IPA"

    expect(beer).to be_valid
  end

  it "cannot be created without name" do
    beer = Beer.new style:"IPA"

    expect(beer).not_to be_valid
  end

  it "cannot be created without style" do
    beer = Beer.new name:"IPA"

    expect(beer).not_to be_valid
  end
end

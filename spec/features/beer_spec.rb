require 'rails_helper'


describe 'Beer' do
  it "is created with valid data" do
    visit new_beer_path
    fill_in('beer_name', with:'Testikalja')

    expect {
      click_button('Create Beer')
    }.to change{Beer.count}.by(1)
  end
  it "is not created with invalid name" do
    visit new_beer_path

    expect{
      click_button('Create Beer')
    }.to change{Beer.count}.by(0)
    expect(page).to have_content "Name can't be blank"
    expect(page).to have_content "New beer"
  end
end
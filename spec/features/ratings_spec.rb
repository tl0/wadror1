require 'rails_helper'


describe 'Rating' do
  let!(:brewery) { FactoryGirl.create :brewery, name:"panimo"}
  let!(:beer) { FactoryGirl.create :beer, name:"kalja1", brewery:brewery}
  let!(:user) { FactoryGirl.create :user}

  before :each do
    sign_in(username:"Pekka", password:"Foobar1")
  end

  describe "when multiple ratings" do
    before :each do
      FactoryGirl.create(:rating, score:10, beer:beer, user:user)
      u2 = FactoryGirl.create(:user, username:"Seppo")
      FactoryGirl.create(:rating, score:10, beer:beer, user:u2)

    end
    it "ratings are shown and count" do
      visit ratings_path
      expect(page).to have_content "Number of ratings 2"
    end

    it "own ratings" do

      visit user_path(user)
      expect(page).to have_content 'Has made 1'
    end

    it "deletes own rating" do
      visit user_path(user)
      expect{
        page.first('a', text:'delete').click
      }.to change{Rating.count}.by(-1)
    end
  end
end
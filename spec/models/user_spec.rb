require 'rails_helper'

RSpec.describe User, type: :model do
  it "has the username set correctly" do
    user = User.new username:"Pekka"

    user.username.should == "Pekka"
  end

  it "is not saved without a password" do
    user = User.create username:"Pekka"

    expect(user).not_to be_valid
    expect(User.count).to eq(0)
  end

  describe "with a proper password" do
    let(:user){ User.create username:"Pekka", password:"Secret1", password_confirmation:"Secret1" }

    it "is saved" do
      expect(user).to be_valid
      expect(User.count).to eq(1)
    end

    it "and with two ratings, has the correct average rating" do
      rating = Rating.new score:10
      rating2 = Rating.new score:20

      user.ratings << rating
      user.ratings << rating2

      expect(user.ratings.count).to eq(2)
      expect(user.average_rating).to eq(15.0)
    end
  end

  it "is not saved if password tshortoo short" do
    user = User.create username:"Pekka", password:"p", password_confirmation:"p"

    expect(user).not_to be_valid
    expect(User.count).to be(0)
  end

  it "is not saved if password contains only letter" do
    user = User.create username:"Pekka", password:"salasanakala", password_confirmation:"salasanakala"

    expect(user).not_to be_valid
    expect(User.count).to be(0)
  end
end

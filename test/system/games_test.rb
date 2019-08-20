require "application_system_test_case"

# Going to the /new game page displays a random grid
# You can fill the form with a random word, click the play button, and get a message that the word is not in the grid.
# You can fill the form with a one-letter consonant word, click play, and get a message it's not a valid English word
# You can fill the form with a valid English word (that's hard because there is randomness!), click play and get a "Congratulations" message

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    assert test: "New game"
    assert_selector "h2", count: 10
  end

  test "Getting a message that the word is not in the grid when filling in a random word" do
    visit new_url
    fill_in "word", with: "flower"
    click_on "Play!"

    assert_text "Sorry but that can't be made from the given letters"
  end

  test "Getting a message that the word is not a valid English word when filling in a random word" do
    visit new_url
    fill_in "word", with: "yy"
    click_on "Play!"

    assert_text "Sorry YY does not seem to be a valid English word"
  end
  # test "visiting the index" do
  #   visit games_url
  #
  #   assert_selector "h1", text: "Game"
  # end
end

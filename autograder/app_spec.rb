require 'mechanize'
require 'json'

# A module that mechs the following spec tests look much cleaner
module MechanizeHelpers

  @@BASE_URI =  ENV['HEROKU_URI'] !~ /^http:\/\// ? "http://" + ENV['HEROKU_URI'] : ENV['HEROKU_URI']

  def guess(letter)
    page = @mech.current_page
    page.form_with(:action => '/guess') do |f|
      f.field_with(:name => 'guess').value = letter
    end.click_button
  end

  def guesses(letters)
    letters.each_char do |letter|
      guess letter
    end
  end

  def new_game(word)
    @mech.post(@@BASE_URI + "/create", {:word => word})
  end

  def click_new_game
    page = @mech.get(@@BASE_URI + "/new")
    form = page.form_with(:action => '/create')
    form.click_button
  end

  def word_board
    page = @mech.current_page
    page.uri.request_uri.should eq("/show")
    page.at("span.word").content
  end

  def wrong_guesses
    page = @mech.current_page
    page.uri.request_uri.should eq "/show"
    page.at("span.guesses").content
  end

  def flash_message
    page = @mech.current_page
    msg = page.at("span.error")
    if msg.nil?
      ""
    else
      msg.content
    end
  end

  def goto(route)
    @mech.get(@@BASE_URI + route)
  end

  def current_route
    @mech.current_page.uri.request_uri
  end
end

# BEGIN SPEC TESTS
# (cucumber tests in disguise)
describe "Hangperson" do

  include MechanizeHelpers
  before :each do
    @mech = Mechanize.new
  end

  describe "game over" do
    it "because the word is guessed [5 points]" do
      new_game "foobar"
      guesses "fobar"
      expect(current_route).to eq("/win")
    end
    it "because the guess limit is reached [5 points]" do
      new_game "zebra"
      guesses "isuckhar"
      expect(current_route).to eq("/show")
      guess "d"
      expect(current_route).to eq("/lose")
    end
  end

  describe "guessing" do
    it "should reveal the letter if it is correct [5 points]" do
      new_game "garply"
      guess "g"
      expect(word_board).to eq("g-----")
    end
    it "should reveal the letter if it appears many times [5 points]" do
      new_game "animal"
      guess "a"
      expect(word_board).to eq("a---a-") 
    end
    it "should add to wrong guesses when incorrect [5 points]" do
      new_game "xylophone"
      guess "a"
      expect(wrong_guesses).to eq("a")
    end
    it "should continuously track right and wrong guesses [5 points]" do
      new_game "foobar"
      guesses "azxo"
      expect(word_board).to eq("-oo-a-")
      expect(wrong_guesses).to eq("zx")
    end
    it "should treat guesses as case insensitive [5 points]" do
      new_game "fiddlesticks"
      guess "t"
      word_board1 = word_board
      guess "T"
      word_board2 = word_board
      guess "q"
      wrong_guesses1 = wrong_guesses
      guess "Q"
      wrong_guesses2 = wrong_guesses
      expect(word_board1).to eq(word_board2)
      expect(wrong_guesses1).to eq(wrong_guesses2)
    end
  end

  describe "guessing repeats" do
    it "should not count as wrong when correct [5 points]" do
      new_game "bumblebee"
      guess "b"
      guess "b"
      guess "b"
      expect(word_board).to eq("b--b--b--")
    end
    it "should not double count a repeated wrong guess [5 points]" do
      new_game "giraffe"
      guess "z"
      guess "z"
      expect(wrong_guesses).to eq("z")
    end
    it "should not count a repeated wrong guess towards losing [5 points]" do
      new_game "snake"
      30.times do
        guess "z"
      end
      expect(current_route).to eq("/show")
    end
    it "should display an error message [5 points]" do
      new_game "figs"
      guess "i"
      guess "i"
      expect(flash_message).to eq("You have already used that letter.")
    end
  end

  describe "invalid guess" do
    it "should label a non-letter as invalid [5 points]" do
      new_game "helterskelter"
      guess "^"
      expect(flash_message).to eq("Invalid guess.")
    end
    it "should label a blank form as invalid [5 points]" do
      new_game "pumpkin"
      guess ""
      expect(flash_message).to eq("Invalid guess.")
    end
  end

  describe "starting a new game" do
    it "should take me to the show page [5 points]" do
      click_new_game
      expect(current_route).to eq("/show")
    end
  end

  describe "cheating" do
    it "should not be able to fake a win [5 points]" do
      new_game "math"
      goto "/win"
      expect(current_route).to eq("/show")
    end
    it "should not be able to fake a loss [5 points]" do
      new_game "howdy"
      goto "/lose"
      expect(current_route).to eq("/show")
    end
  end

end

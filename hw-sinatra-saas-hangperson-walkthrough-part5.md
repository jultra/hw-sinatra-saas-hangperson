So let's follow the instructions to get things all passing:

1.  Pick a new scenario to work on (you should have 2/4 working at this point)
2.  Run the scenario and watch it fail
3.  Develop code that makes each step of the scenario pass
4.  Repeat till all steps passing.

At this point the following should be failing:

```sh
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ bundle exec cucumber -f progress


REMOVED ERROR DETAILS

cucumber features/game_over.feature:7 # Scenario: game over because I guess the word
cucumber features/game_over.feature:13 # Scenario: game over because I run out of guesses
cucumber features/repeated_guess.feature:7 # Scenario: guess correct letter that I have already tried
cucumber features/repeated_guess.feature:15 # Scenario: guess incorrect letter that I have already tried
```

Let's take the first:

```sh
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ bundle exec cucumber features/game_over.feature:7
Feature: game over
  
  As a player playing Hangperson
  So I can get back to my life 
  I want to know when the game is over

  Scenario: game over because I guess the word   # features/game_over.feature:7
    Given I start a new game with word "foobar"  # features/step_definitions/game_steps.rb:12
    When I make the following guesses: f,o,b,a,r # features/step_definitions/game_steps.rb:25
    Then I should see "You Win!"                 # features/step_definitions/game_steps.rb:72
      expected to find text "You Win!" in "Play Hangperson! Guess a letter Wrong Guesses: Word so far: foobar Random word generator provided by Watchout4snakes.com -- thanks!" (RSpec::Expectations::ExpectationNotMetError)
      ./features/step_definitions/game_steps.rb:75:in `block (2 levels) in <top (required)>'
      ./features/step_definitions/game_steps.rb:7:in `with_scope'
      ./features/step_definitions/game_steps.rb:73:in `/^(?:|I )should see "([^\"]*)"(?: within "([^\"]*)")?$/'
      features/game_over.feature:11:in `Then I should see "You Win!"'

Failing Scenarios:
cucumber features/game_over.feature:7 # Scenario: game over because I guess the word

1 scenario (1 failed)
3 steps (1 failed, 2 passed)
0m0.112s
Coverage report generated for Cucumber Features to /home/ubuntu/workspace/hw-sinatra-saas-hangperson/coverage. 55 / 61 LOC (90.16%) covered.
```

So this is a problem with not displaying the winning condition.  If we look at app.rb we see:

```rb
  get '/win' do
    ### YOUR CODE HERE ###
    erb :win # You may change/remove this line
  end
```

the view is already set up for us:

```erb
<h1>You Win!</h1>

<p>
  The word was
  <span class="win"><%= @game.word %></span>.
</p>

<%= erb :new %>

```

Looking at our current guess method in app.rb:

```rb
  post '/guess' do
    letter = params[:guess].to_s[0]
    ### YOUR CODE HERE ###
    
    @game.guess(letter)
    
    redirect '/show'
  end
```

it looks like we are always redirecting to the show method, which has some interesting notes:

```rb
  # Everytime a guess is made, we should eventually end up at this route.
  # Use existing methods in HangpersonGame to check if player has
  # won, lost, or neither, and take the appropriate action.
  # Notice that the show.erb template expects to use the instance variables
  # wrong_guesses and word_with_guesses from @game.
  get '/show' do
    ### YOUR CODE HERE ###
    erb :show # You may change/remove this line
  end
```

Here we might get distracted by adding things we think we need, or the comments hint we need, but let's stay focused on what the test is asking for, which is that we show the win output in appropriate situations.

We have a `check_win_or_lose` method in our hang person game:

```rb
  def check_win_or_lose
    return :lose if @wrong_guesses.length >= 7
    return :win if @word.chars - @guesses.chars == []
    :play
  end
```

let's use that to choose our template ... 

```rb
  get '/show' do
    ### YOUR CODE HERE ###
    state = @game.check_win_or_lose
    state = :show if state == :play
    erb state # You may change/remove this line
  end
```

I could have done less here, as this has probably made some other tests pass, but it's too tempting when the `check_win_or_lose` returns two symbols which match the erb template names.  Checking we should see our test pass:

```sh
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ bundle exec cucumber features/game_over.feature:7
Feature: game over
  
  As a player playing Hangperson
  So I can get back to my life 
  I want to know when the game is over

  Scenario: game over because I guess the word   # features/game_over.feature:7
    Given I start a new game with word "foobar"  # features/step_definitions/game_steps.rb:12
    When I make the following guesses: f,o,b,a,r # features/step_definitions/game_steps.rb:25
    Then I should see "You Win!"                 # features/step_definitions/game_steps.rb:72

1 scenario (1 passed)
3 steps (3 passed)
0m0.089s
Coverage report generated for Cucumber Features to /home/ubuntu/workspace/hw-sinatra-saas-hangperson/coverage. 60 / 63 LOC (95.24%) covered.
```

Let's check for side-effects:

```sh
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ bundle exec cucumber -f progress
........................F....F........

REMOVED ERROR DETAILS

Failing Scenarios:
cucumber features/repeated_guess.feature:7 # Scenario: guess correct letter that I have already tried
cucumber features/repeated_guess.feature:15 # Scenario: guess incorrect letter that I have already tried


10 scenarios (2 failed, 8 passed)
38 steps (2 failed, 36 passed)
0m0.492s
Coverage report generated for Cucumber Features to /home/ubuntu/workspace/hw-sinatra-saas-hangperson/coverage. 61 / 63 LOC (96.83%) covered.
```

So it looks like all our game over tests are passing, and we haven't broken any existing tests.  Let's go on and deal with these repeated guess failures.

```sh
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ bundle exec cucumber features/repeated_guess.feature:7
Feature: guess repeated letter
  
  As a player playing Hangperson
  So that I can avoid wasting guesses on letters I've already tried
  I want to be informed when I guess a letter I've already tried

  Scenario: guess correct letter that I have already tried # features/repeated_guess.feature:7
    Given I start a new game with word "bumblebee"         # features/step_definitions/game_steps.rb:12
    When I guess "b"                                       # features/step_definitions/game_steps.rb:19
    And I guess "b" again                                  # features/step_definitions/game_steps.rb:19
    Then the word should read "b--b--b--"                  # features/step_definitions/game_steps.rb:34
    And I should see "You have already used that letter"   # features/step_definitions/game_steps.rb:72
      expected to find text "You have already used that letter" in "Play Hangperson! Guess a letter Wrong Guesses: Word so far: b--b--b-- Random word generator provided by Watchout4snakes.com -- thanks!" (RSpec::Expectations::ExpectationNotMetError)
      ./features/step_definitions/game_steps.rb:75:in `block (2 levels) in <top (required)>'
      ./features/step_definitions/game_steps.rb:7:in `with_scope'
      ./features/step_definitions/game_steps.rb:73:in `/^(?:|I )should see "([^\"]*)"(?: within "([^\"]*)")?$/'
      features/repeated_guess.feature:13:in `And I should see "You have already used that letter"'

Failing Scenarios:
cucumber features/repeated_guess.feature:7 # Scenario: guess correct letter that I have already tried

1 scenario (1 failed)
5 steps (1 failed, 4 passed)
0m0.091s
Coverage report generated for Cucumber Features to /home/ubuntu/workspace/hw-sinatra-saas-hangperson/coverage. 60 / 63 LOC (95.24%) covered.

```


so we need to display "You have already used that letter" at the appropriate time.  There are comments around app.rb's `guess` method that hint at a solution:


```rb
  # Use existing methods in HangpersonGame to process a guess.
  # If a guess is repeated, set flash[:message] to "You have already used that letter."
  # If a guess is invalid, set flash[:message] to "Invalid guess."
  post '/guess' do
    letter = params[:guess].to_s[0]
    ### YOUR CODE HERE ###
    
    @game.guess(letter)
    
    redirect '/show'
  end
```

so we can fix that with:

```rb
  post '/guess' do
    letter = params[:guess].to_s[0]
    ### YOUR CODE HERE ###
    
    valid = @game.guess(letter)
    flash[:message] = "You have already used that letter." unless valid
    
    redirect '/show'
  end
```

and has the side effect of making all the tests pass:

```sh
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ bundle exec cucumber -f progress
......................................

10 scenarios (10 passed)
38 steps (38 passed)
0m0.493s
Coverage report generated for Cucumber Features to /home/ubuntu/workspace/hw-sinatra-saas-hangperson/coverage. 62 / 64 LOC (96.88%) covered.
```

which is slightly confusing because we haven't done everything suggested, and there seems to be some confusion about whether a repeated letter is different from invalid.  Since here we are setting, you've already used that letter as being based on the "validity" returned by the `guess` method.


Anyhow, we can push this code to heroku:

```sh
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ git status
On branch master
Your branch is ahead of 'origin/master' by 2 commits.
  (use "git push" to publish your local commits)
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   app.rb
        modified:   features/step_definitions/game_steps.rb

no changes added to commit (use "git add" and/or "git commit -a")
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ git commit -am 'all cukes passing'
[master aaa7920] all cukes passing
 2 files changed, 8 insertions(+), 1 deletion(-)
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ git remote -v
heroku  https://git.heroku.com/hangperson-clean2017.git (fetch)
heroku  https://git.heroku.com/hangperson-clean2017.git (push)
origin  https://github.com/saasbook/hw-sinatra-saas-hangperson (fetch)
origin  https://github.com/saasbook/hw-sinatra-saas-hangperson (push)
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ git push heroku master
Counting objects: 6, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (5/5), done.
Writing objects: 100% (6/6), 627 bytes | 0 bytes/s, done.
Total 6 (delta 4), reused 0 (delta 0)
remote: Compressing source files... done.
remote: Building source:
remote: 
remote: -----> Ruby app detected
remote: -----> Compiling Ruby/Rack
remote: -----> Using Ruby version: ruby-2.3.0
remote: -----> Installing dependencies using bundler 1.15.2
remote:        Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment
remote:        Fetching gem metadata from https://rubygems.org/.........
remote:        Fetching version metadata from https://rubygems.org/.
remote:        Using bundler 1.15.2
remote:        Using rack 1.6.4
remote:        Using tilt 2.0.5
remote:        Using rack-protection 1.5.3
remote:        Using sinatra 1.4.7
remote:        Using sinatra-flash 0.3.0
remote:        Bundle complete! 15 Gemfile dependencies, 6 gems now installed.
remote:        Gems in the groups development and test were not installed.
remote:        Bundled gems are installed into ./vendor/bundle.
remote:        Bundle completed (1.72s)
remote:        Cleaning up the bundler cache.
remote: -----> Detecting rake tasks
remote: 
remote: -----> Discovering process types
remote:        Procfile declares types     -> web
remote:        Default types for buildpack -> console, rake
remote: 
remote: -----> Compressing...
remote:        Done: 17.7M
remote: -----> Launching...
remote:        Released v6
remote:        https://hangperson-clean2017.herokuapp.com/ deployed to Heroku
remote: 
remote: Verifying deploy... done.
To https://git.heroku.com/hangperson-clean2017.git
   92d8f90..aaa7920  master -> master
```

And we will see that we get 62.5% on the autograder, with output like this:

```
Score: 50/80

Hangperson
  game over
    because the word is guessed [5 points] (FAILED - 1)
    because the guess limit is reached [5 points] (FAILED - 2)
  guessing
    should reveal the letter if it is correct [5 points]
    should reveal the letter if it appears many times [5 points]
    should add to wrong guesses when incorrect [5 points]
    should continuously track right and wrong guesses [5 points]
    should treat guesses as case insensitive [5 points]
  guessing repeats
    should not count as wrong when correct [5 points]
    should not uble count a repeated wrong guess [5 points]
    should not count a repeated wrong guess towards losing [5 points]
    should display an error message [5 points]
  invalid guess
    should label a non-letter as invalid [5 points] (FAILED - 3)
    should label a blank form as invalid [5 points] (FAILED - 4)
  starting a new game
    should take me to the show page [5 points]
  cheating
    should not be able to fake a win [5 points] (FAILED - 5)
    should not be able to fake a loss [5 points] (FAILED - 6)

Failures:

  1) Hangperson game over because the word is guessed [5 points]
     Failure/Error: expect(current_route).to eq("/win")

       expected: "/win"
            got: "/show"

       (compared using ==)

  2) Hangperson game over because the guess limit is reached [5 points]
     Failure/Error: expect(current_route).to eq("/lose")

       expected: "/lose"
            got: "/show"

       (compared using ==)

  3) Hangperson invalid guess should label a non-letter as invalid [5 points]
     Failure/Error:
       page.form_with(:action => '/guess') do |f|
         f.field_with(:name => 'guess').value = letter
       end.click_button

     Mechanize::ResponseCodeError:
       500 => Net::HTTPInternalServerError for http://hangperson-clean2017.herokuapp.com/guess -- unhandled response

  4) Hangperson invalid guess should label a blank form as invalid [5 points]
     Failure/Error:
       page.form_with(:action => '/guess') do |f|
         f.field_with(:name => 'guess').value = letter
       end.click_button

     Mechanize::ResponseCodeError:
       500 => Net::HTTPInternalServerError for http://hangperson-clean2017.herokuapp.com/guess -- unhandled response

  5) Hangperson cheating should not be able to fake a win [5 points]
     Failure/Error: expect(current_route).to eq("/show")

       expected: "/show"
            got: "/win"

       (compared using ==)

  6) Hangperson cheating should not be able to fake a loss [5 points]
     Failure/Error: expect(current_route).to eq("/show")

       expected: "/show"
            got: "/lose"

       (compared using ==)

1 deprecation warning total

Finished in 4.69 seconds (files took 14102 minutes 56 seconds to load)
16 examples, 6 failures

Failed examples:

rspec ./your_code.rb:73 # Hangperson game over because the word is guessed [5 points]
rspec ./your_code.rb:78 # Hangperson game over because the guess limit is reached [5 points]
rspec ./your_code.rb:154 # Hangperson invalid guess should label a non-letter as invalid [5 points]
rspec ./your_code.rb:159 # Hangperson invalid guess should label a blank form as invalid [5 points]
rspec ./your_code.rb:174 # Hangperson cheating should not be able to fake a win [5 points]
rspec ./your_code.rb:179 # Hangperson cheating should not be able to fake a loss [5 points]
```

because we've got extra tests in the grader that checks that are not in our local test suite ...

we can fix the cheating issues by removing the following direct endpoints from app.rb:

```rb
  get '/win' do
    ### YOUR CODE HERE ###
    erb :win # You may change/remove this line
  end
  
  get '/lose' do
    ### YOUR CODE HERE ###
    erb :lose # You may change/remove this line
  end
```

and the "invalid" guesses, but catching the appropriate error:

```rb
  post '/guess' do
    letter = params[:guess].to_s[0]
    ### YOUR CODE HERE ###
    begin  
      valid = @game.guess(letter)
      flash[:message] = "You have already used that letter." unless valid
    rescue ArgumentError
      flash[:message] = "Invalid guess."
    end
    redirect '/show'
  end
```

```sh
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ bundle exec cucumber -f progress
......................................

10 scenarios (10 passed)
38 steps (38 passed)
0m0.613s
Coverage report generated for Cucumber Features to /home/ubuntu/workspace/hw-sinatra-saas-hangperson/coverage. 61 / 62 LOC (98.39%) covered.
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ git commit -am 'defending against cheating and invalid guesses'
[master 4373e17] defending against cheating and invalid guesses
 1 file changed, 6 insertions(+), 14 deletions(-)
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ git push heroku master
```
```

This doesn't do all we want on the grader:

```
Score: 60/80

Hangperson
  game over
    because the word is guessed [5 points] (FAILED - 1)
    because the guess limit is reached [5 points] (FAILED - 2)
  guessing
    should reveal the letter if it is correct [5 points]
    should reveal the letter if it appears many times [5 points]
    should add to wrong guesses when incorrect [5 points]
    should continuously track right and wrong guesses [5 points]
    should treat guesses as case insensitive [5 points]
  guessing repeats
    should not count as wrong when correct [5 points]
    should not uble count a repeated wrong guess [5 points]
    should not count a repeated wrong guess towards losing [5 points]
    should display an error message [5 points]
  invalid guess
    should label a non-letter as invalid [5 points]
    should label a blank form as invalid [5 points]
  starting a new game
    should take me to the show page [5 points]
  cheating
    should not be able to fake a win [5 points] (FAILED - 3)
    should not be able to fake a loss [5 points] (FAILED - 4)

Failures:

  1) Hangperson game over because the word is guessed [5 points]
     Failure/Error: expect(current_route).to eq("/win")

       expected: "/win"
            got: "/show"

       (compared using ==)

  2) Hangperson game over because the guess limit is reached [5 points]
     Failure/Error: expect(current_route).to eq("/lose")

       expected: "/lose"
            got: "/show"

       (compared using ==)

  3) Hangperson cheating should not be able to fake a win [5 points]
     Failure/Error: @mech.get(@@BASE_URI + route)

     Mechanize::ResponseCodeError:
       404 => Net::HTTPNotFound for http://hangperson-clean2017.herokuapp.com/win -- unhandled response

  4) Hangperson cheating should not be able to fake a loss [5 points]
     Failure/Error: @mech.get(@@BASE_URI + route)

     Mechanize::ResponseCodeError:
       404 => Net::HTTPNotFound for http://hangperson-clean2017.herokuapp.com/lose -- unhandled response

1 deprecation warning total

Finished in 2.13 seconds (files took 14110 minutes 28 seconds to load)
16 examples, 4 failures

Failed examples:

rspec ./your_code.rb:73 # Hangperson game over because the word is guessed [5 points]
rspec ./your_code.rb:78 # Hangperson game over because the guess limit is reached [5 points]
rspec ./your_code.rb:174 # Hangperson cheating should not be able to fake a win [5 points]
rspec ./your_code.rb:179 # Hangperson cheating should not be able to fake a loss [5 points]
```

since it looks like removing the endpoints for cheating breaks the grader and we still need to handle these routes ... the implication from the grader is that we must redirect ... which implies we need something like this:

```rb
  get '/show' do
    ### YOUR CODE HERE ###
    state = @game.check_win_or_lose
    redirect '/win' if state == :win
    redirect '/lose' if state == :lose
    erb :show # You may change/remove this line
  end
  
  get '/win' do
    ### YOUR CODE HERE ###
    redirect '/show' unless @game.check_win_or_lose == :win
    erb :win # You may change/remove this line
  end
  
  get '/lose' do
    ### YOUR CODE HERE ###
     redirect '/show' unless @game.check_win_or_lose == :lose
    erb :lose # You may change/remove this line
  end
```

and if we push this to heroku ... we get 100% from the autograder:

```
Your submission was recorded at 2017-08-17 04:09:51 +0000 : submission is on time.
Score: 80/80

Hangperson
  game over
    because the word is guessed [5 points]
    because the guess limit is reached [5 points]
  guessing
    should reveal the letter if it is correct [5 points]
    should reveal the letter if it appears many times [5 points]
    should add to wrong guesses when incorrect [5 points]
    should continuously track right and wrong guesses [5 points]
    should treat guesses as case insensitive [5 points]
  guessing repeats
    should not count as wrong when correct [5 points]
    should not uble count a repeated wrong guess [5 points]
    should not count a repeated wrong guess towards losing [5 points]
    should display an error message [5 points]
  invalid guess
    should label a non-letter as invalid [5 points]
    should label a blank form as invalid [5 points]
  starting a new game
    should take me to the show page [5 points]
  cheating
    should not be able to fake a win [5 points]
    should not be able to fake a loss [5 points]

1 deprecation warning total

Finished in 3.11 seconds (files took 14116 minutes 16 seconds to load)
16 examples, 0 failures
```







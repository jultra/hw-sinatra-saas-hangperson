So more self-check questions and then we need to see the cucumber test fail:

```
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ cucumber features/start_new_game.feature
Feature: start new game
  
  As a player
  So I can play Hangperson
  I want to start a new game

  Scenario: I start a new game         # features/start_new_game.feature:7
    Given I am on the home page        # features/step_definitions/game_steps.rb:58
    And I press "New Game"             # features/step_definitions/game_steps.rb:81
    Then I should see "Guess a letter" # features/step_definitions/game_steps.rb:71
      expected to find text "Guess a letter" in "Not Found" (RSpec::Expectations::ExpectationNotMetError)
      ./features/step_definitions/game_steps.rb:74:in `block (2 levels) in <top (required)>'
      ./features/step_definitions/game_steps.rb:7:in `with_scope'
      ./features/step_definitions/game_steps.rb:72:in `/^(?:|I )should see "([^\"]*)"(?: within "([^\"]*)")?$/'
      features/start_new_game.feature:11:in `Then I should see "Guess a letter"'
    And I press "New Game"             # features/step_definitions/game_steps.rb:81
    Then I should see "Guess a letter" # features/step_definitions/game_steps.rb:71

Failing Scenarios:
cucumber features/start_new_game.feature:7 # Scenario: I start a new game

1 scenario (1 failed)
5 steps (1 failed, 2 skipped, 2 passed)
0m0.113s
Coverage report generated for Cucumber Features to /home/ubuntu/workspace/hw-sinatra-saas-hangperson/coverage. 35 / 60 LOC (58.33%) covered.
```

then make the necessary change to the form:

```erb
<form action='/create' method="post">
  <input type="submit" value="New Game"/>
</form>
```

and then see the test pass


```sh
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ cucumber features/start_new_game.feature
Feature: start new game
  
  As a player
  So I can play Hangperson
  I want to start a new game

  Scenario: I start a new game         # features/start_new_game.feature:7
    Given I am on the home page        # features/step_definitions/game_steps.rb:58
    And I press "New Game"             # features/step_definitions/game_steps.rb:81
    Then I should see "Guess a letter" # features/step_definitions/game_steps.rb:71
    And I press "New Game"             # features/step_definitions/game_steps.rb:81
    Then I should see "Guess a letter" # features/step_definitions/game_steps.rb:71

1 scenario (1 passed)
5 steps (5 passed)
0m0.198s
Coverage report generated for Cucumber Features to /home/ubuntu/workspace/hw-sinatra-saas-hangperson/coverage. 44 / 60 LOC (73.33%) covered.
```

Now let's deploy that to heroku, first by committing locally:

```sh
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ git status
On branch master
Your branch is ahead of 'origin/master' by 1 commit.
  (use "git push" to publish your local commits)
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   views/new.erb

no changes added to commit (use "git add" and/or "git commit -a")
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ git diff
diff --git a/views/new.erb b/views/new.erb
index 23f0c8b..1884d4b 100644
--- a/views/new.erb
+++ b/views/new.erb
@@ -1,4 +1,4 @@
 <!-- This form is incomplete--it needs a destination URL as well as a method: -->
-<form method="post">
+<form action='/create' method="post">
   <input type="submit" value="New Game"/>
 </form>
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ git commit -am 'fix new.erb form'
[master 92d8f90] fix new.erb form
 1 file changed, 1 insertion(+), 1 deletion(-)
```

and using to heroku

```sh
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ git push heroku master
Counting objects: 4, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (4/4), done.
Writing objects: 100% (4/4), 371 bytes | 0 bytes/s, done.
Total 4 (delta 3), reused 0 (delta 0)
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
remote:        Bundle completed (3.50s)
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
remote:        Released v5
remote:        https://hangperson-clean2017.herokuapp.com/ deployed to Heroku
remote: 
remote: Verifying deploy... done.
To https://git.heroku.com/hangperson-clean2017.git
   520023e..92d8f90  master -> master
```


which should allow us to get to this view on heroku:

![](images/Screenshot%202017-08-08%2014.27.21.png)

Now let's update the `guess` code in the Sinatra `app.rb`.  Note that if we run the feature at this point, we'll see a single failure:

```sh
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ cucumber features/guess.feature 
Feature: guess correct letter
  
  As a player playing Hangperson
  So that I can make progress toward the goal
  I want to see when my guess is correct

  Scenario: guess correct letter that occurs once # features/guess.feature:7
    Given I start a new game with word "garply"   # features/step_definitions/game_steps.rb:12
    When I guess "r"                              # features/step_definitions/game_steps.rb:19
    Then I should see "r" within "span.word"      # features/step_definitions/game_steps.rb:71

  Scenario: guess correct letter that occurs multiple times # features/guess.feature:13
    Given I start a new game with word "animal"             # features/step_definitions/game_steps.rb:12
    When I guess "a"                                        # features/step_definitions/game_steps.rb:19
    Then I should see "a---a-" within "span.word"           # features/step_definitions/game_steps.rb:71

  Scenario: guess incorrect letter                 # features/guess.feature:19
    Given I start a new game with word "xylophone" # features/step_definitions/game_steps.rb:12
    When I guess "a"                               # features/step_definitions/game_steps.rb:19
    Then I should see "a" within "span.guesses"    # features/step_definitions/game_steps.rb:71

  Scenario: multiple correct and incorrect guesses # features/guess.feature:25
    Given I start a new game with word "foobar"    # features/step_definitions/game_steps.rb:12
    When I make the following guesses: a,z,x,o     # features/step_definitions/game_steps.rb:25
    Then the word should read "-oo-a-"             # features/step_definitions/game_steps.rb:33
      expected to find text "-oo-a-" in "Play Hangperson! Guess a letter Wrong Guesses: Word so far: ------ Random word generator provided by Watchout4snakes.com -- thanks!" (RSpec::Expectations::ExpectationNotMetError)
      ./features/step_definitions/game_steps.rb:34:in `/^the word should read "(.*)"$/'
      features/guess.feature:29:in `Then the word should read "-oo-a-"'
    And the wrong guesses should include: z,x      # features/step_definitions/game_steps.rb:37

Failing Scenarios:
cucumber features/guess.feature:25 # Scenario: multiple correct and incorrect guesses

4 scenarios (1 failed, 3 passed)
13 steps (1 failed, 1 skipped, 11 passed)
0m0.322s
Coverage report generated for Cucumber Features to /home/ubuntu/workspace/hw-sinatra-saas-hangperson/coverage. 45 / 60 LOC (75.0%) covered.
```

If we update the `guess` method as follows:

```
  post '/guess' do
    letter = params[:guess].to_s[0]
    ### YOUR CODE HERE ###
    
    @game.guess(letter)
    
    redirect '/show'
  end

```

we should see the final test pass:

```sh
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ cucumber features/guess.feature 
Feature: guess correct letter
  
  As a player playing Hangperson
  So that I can make progress toward the goal
  I want to see when my guess is correct

  Scenario: guess correct letter that occurs once # features/guess.feature:7
    Given I start a new game with word "garply"   # features/step_definitions/game_steps.rb:12
    When I guess "r"                              # features/step_definitions/game_steps.rb:19
    Then I should see "r" within "span.word"      # features/step_definitions/game_steps.rb:71

  Scenario: guess correct letter that occurs multiple times # features/guess.feature:13
    Given I start a new game with word "animal"             # features/step_definitions/game_steps.rb:12
    When I guess "a"                                        # features/step_definitions/game_steps.rb:19
    Then I should see "a---a-" within "span.word"           # features/step_definitions/game_steps.rb:71

  Scenario: guess incorrect letter                 # features/guess.feature:19
    Given I start a new game with word "xylophone" # features/step_definitions/game_steps.rb:12
    When I guess "a"                               # features/step_definitions/game_steps.rb:19
    Then I should see "a" within "span.guesses"    # features/step_definitions/game_steps.rb:71

  Scenario: multiple correct and incorrect guesses # features/guess.feature:25
    Given I start a new game with word "foobar"    # features/step_definitions/game_steps.rb:12
    When I make the following guesses: a,z,x,o     # features/step_definitions/game_steps.rb:25
    Then the word should read "-oo-a-"             # features/step_definitions/game_steps.rb:33
    And the wrong guesses should include: z,x      # features/step_definitions/game_steps.rb:37

4 scenarios (4 passed)
13 steps (13 passed)
0m0.274s
Coverage report generated for Cucumber Features to /home/ubuntu/workspace/hw-sinatra-saas-hangperson/coverage. 55 / 61 LOC (90.16%) covered.
```

Note that launchy doesn't work on c9:

https://community.c9.io/t/getting-launchy-gem-to-work-on-cloud9/9896

unless one installs IceWeasel:

```
sudo apt-get install iceweasel
```



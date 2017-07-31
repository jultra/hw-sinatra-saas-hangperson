Note that these are opinionated walkthroughs from Sam Joseph.  Opinions expressed are those of Sam Joseph alone and do not necessarily reflect the opinions of UCBerkeley or any to it's employees.

We start by following the instructions to clone the skeleton code.  Note that we should do this in the root workspace/ directory on c9 to avoid a git clobber.  Specifically we move out of the previous hello-world app dir and onto the c9 root to create a new project with it's own git control.

```sh
c9testaduror:~/workspace $ git clone https://github.com/saasbook/hw-sinatra-saas-hangperson
Cloning into 'hw-sinatra-saas-hangperson'...
remote: Counting objects: 348, done.
remote: Compressing objects: 100% (15/15), done.
remote: Total 348 (delta 9), reused 14 (delta 5), pack-reused 328
Receiving objects: 100% (348/348), 158.90 KiB | 0 bytes/s, done.
Resolving deltas: 100% (182/182), done.
```

Then we move into that directory and try to run `bundle exec auto test` as specified

```sh
c9testaduror:~/workspace $ cd hw-sinatra-saas-hangperson/
RVM used your Gemfile for selecting Ruby, it is all fine - Heroku does that too,
you can ignore these warnings with 'rvm rvmrc warning ignore /home/ubuntu/workspace/hw-sinatra-saas-hangperson/Gemfile'.
To ignore the warning for all files run 'rvm rvmrc warning ignore allGemfiles'.

c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ bundle exec autotest
bundler: command not found: autotest
Install missing gem executables with `bundle install`
```

which gives us an error reminding us to run `bundle install` or the equivalent `bundle`.  This may take some time to complete:


```sh
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ bundle
Fetching gem metadata from https://rubygems.org/.........
Fetching version metadata from https://rubygems.org/..
Fetching dependency metadata from https://rubygems.org/.
Fetching ZenTest 4.11.0
Installing ZenTest 4.11.0
Fetching addressable 2.4.0
Installing addressable 2.4.0
Fetching builder 3.2.2
Installing builder 3.2.2
Using bundler 1.15.3
Fetching columnize 0.9.0
Installing columnize 0.9.0
Fetching mime-types-data 3.2016.0521
Installing mime-types-data 3.2016.0521
Fetching mini_portile2 2.1.0
Installing mini_portile2 2.1.0
Fetching pkg-config 1.1.7
Installing pkg-config 1.1.7
Fetching rack 1.6.4
Installing rack 1.6.4
Fetching hitimes 1.2.4
Installing hitimes 1.2.4 with native extensions
Fetching safe_yaml 1.0.4
Installing safe_yaml 1.0.4
Fetching multi_json 1.12.1
Installing multi_json 1.12.1
Fetching diff-lcs 1.2.5
Installing diff-lcs 1.2.5
Fetching multi_test 0.1.2
Installing multi_test 0.1.2
Fetching extlib 0.9.16
Installing extlib 0.9.16
Fetching highline 1.7.8
Installing highline 1.7.8
Fetching docile 1.1.5
Installing docile 1.1.5
Fetching ffi 1.9.10
Installing ffi 1.9.10 with native extensions
Using json 1.8.3
Fetching rb-fsevent 0.9.7
Installing rb-fsevent 0.9.7
Fetching rspec-support 3.3.0
Installing rspec-support 3.3.0
Fetching simplecov-html 0.10.0
Installing simplecov-html 0.10.0
Fetching tilt 2.0.5
Installing tilt 2.0.5
Fetching launchy 2.4.3
Installing launchy 2.4.3
Fetching byebug 5.0.0
Installing byebug 5.0.0 with native extensions
Fetching mime-types 3.1
Installing mime-types 3.1
Fetching nokogiri 1.6.8
Installing nokogiri 1.6.8 with native extensions
Fetching rack-test 0.6.3
Installing rack-test 0.6.3
Fetching rack-protection 1.5.3
Installing rack-protection 1.5.3
Fetching rack_session_access 0.1.1
Installing rack_session_access 0.1.1
Fetching timers 4.0.4
Installing timers 4.0.4
Fetching crack 0.4.3
Installing crack 0.4.3
Fetching gherkin 2.12.2
Installing gherkin 2.12.2 with native extensions
Fetching templater 1.0.0
Installing templater 1.0.0
Fetching rb-inotify 0.9.7
Installing rb-inotify 0.9.7
Fetching rspec-core 3.3.2
Installing rspec-core 3.3.2
Fetching rspec-expectations 3.3.1
Installing rspec-expectations 3.3.1
Fetching rspec-mocks 3.3.2
Installing rspec-mocks 3.3.2
Fetching simplecov 0.10.0
Installing simplecov 0.10.0
Fetching xpath 2.0.0
Installing xpath 2.0.0
Fetching sinatra 1.4.7
Installing sinatra 1.4.7
Fetching celluloid 0.16.0
Installing celluloid 0.16.0
Fetching webmock 1.21.0
Installing webmock 1.21.0
Fetching cucumber-core 1.1.3
Installing cucumber-core 1.1.3
Fetching cucumber-sinatra 0.5.0
Installing cucumber-sinatra 0.5.0
Fetching rspec-autotest 1.0.0
Installing rspec-autotest 1.0.0
Fetching rspec 3.3.0
Installing rspec 3.3.0
Fetching capybara 2.4.4
Installing capybara 2.4.4
Fetching sinatra-flash 0.3.0
Installing sinatra-flash 0.3.0
Fetching listen 2.10.1
Installing listen 2.10.1
Fetching cucumber 2.0.0
Installing cucumber 2.0.0
Fetching rerun 0.10.0
Installing rerun 0.10.0
Bundle complete! 15 Gemfile dependencies, 52 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```


Now `autotest` will give us the following, largely yellow, output:

```sh
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ bundle exec autotest
(Not running features.  To run features in autotest, set AUTOFEATURE=true.)
loading autotest/rspec
"/usr/local/rvm/rubies/ruby-2.3.0/bin/ruby" -rrubygems -S "/usr/local/rvm/gems/ruby-2.3.0/gems/rspec-core-3.3.2/exe/rspec" --tty "/home/ubuntu/workspace/hw-sinatra-saas-hangperson/spec/hangperson_game_spec.rb"

HangpersonGame
  new
    takes a parameter and returns a HangpersonGame object (PENDING: No reason given)
  guessing
    correctly
      changes correct guess list (PENDING: No reason given)
      returns true (PENDING: No reason given)
    incorrectly
      changes wrong guess list (PENDING: No reason given)
      returns true (PENDING: No reason given)
    same letter repeatedly
      does not change correct guess list (PENDING: No reason given)
      does not change wrong guess list (PENDING: No reason given)
      returns false (PENDING: No reason given)
      is case insensitive (PENDING: No reason given)
    invalid
      throws an error when empty (PENDING: No reason given)
      throws an error when not a letter (PENDING: No reason given)
      throws an error when nil (PENDING: No reason given)
  displayed word with guesses
    should be 'b-n-n-' when guesses are 'bn' (PENDING: No reason given)
    should be '------' when guesses are 'def' (PENDING: No reason given)
    should be 'banana' when guesses are 'ban' (PENDING: No reason given)
  game status
    should be win when all letters guessed (PENDING: No reason given)
    should be lose after 7 incorrect guesses (PENDING: No reason given)
    should continue play if neither win nor lose (PENDING: No reason given)

Pending: (Failures listed here are expected and do not affect your suite's status)

  1) HangpersonGame new takes a parameter and returns a HangpersonGame object
     # No reason given
     Failure/Error: expect(@hangpersonGame.word).to eq('glorp')
     NoMethodError:
       undefined method `word' for #<HangpersonGame:0x00000002e23f18 @word="glorp">
     # ./spec/hangperson_game_spec.rb:16:in `block (3 levels) in <top (required)>'

  2) HangpersonGame guessing correctly changes correct guess list
     # No reason given
     Failure/Error: @valid = @game.guess('a')
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000002e1d1b8 @word="garply">
     # ./spec/hangperson_game_spec.rb:26:in `block (4 levels) in <top (required)>'

  3) HangpersonGame guessing correctly returns true
     # No reason given
     Failure/Error: @valid = @game.guess('a')
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000002e1a7b0 @word="garply">
     # ./spec/hangperson_game_spec.rb:26:in `block (4 levels) in <top (required)>'

  4) HangpersonGame guessing incorrectly changes wrong guess list
     # No reason given
     Failure/Error: @valid = @game.guess('z')
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000002e17510 @word="garply">
     # ./spec/hangperson_game_spec.rb:39:in `block (4 levels) in <top (required)>'

  5) HangpersonGame guessing incorrectly returns true
     # No reason given
     Failure/Error: @valid = @game.guess('z')
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000002e14798 @word="garply">
     # ./spec/hangperson_game_spec.rb:39:in `block (4 levels) in <top (required)>'

  6) HangpersonGame guessing same letter repeatedly does not change correct guess list
     # No reason given
     Failure/Error: game.guess(letter)
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000002e09168 @word="garply">
     # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
     # ./spec/hangperson_game_spec.rb:7:in `chars'
     # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
     # ./spec/hangperson_game_spec.rb:52:in `block (4 levels) in <top (required)>'

  7) HangpersonGame guessing same letter repeatedly does not change wrong guess list
     # No reason given
     Failure/Error: game.guess(letter)
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000002e02390 @word="garply">
     # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
     # ./spec/hangperson_game_spec.rb:7:in `chars'
     # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
     # ./spec/hangperson_game_spec.rb:52:in `block (4 levels) in <top (required)>'

  8) HangpersonGame guessing same letter repeatedly returns false
     # No reason given
     Failure/Error: game.guess(letter)
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000002dfee98 @word="garply">
     # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
     # ./spec/hangperson_game_spec.rb:7:in `chars'
     # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
     # ./spec/hangperson_game_spec.rb:52:in `block (4 levels) in <top (required)>'

  9) HangpersonGame guessing same letter repeatedly is case insensitive
     # No reason given
     Failure/Error: game.guess(letter)
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000002dfdde0 @word="garply">
     # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
     # ./spec/hangperson_game_spec.rb:7:in `chars'
     # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
     # ./spec/hangperson_game_spec.rb:52:in `block (4 levels) in <top (required)>'

  10) HangpersonGame guessing invalid throws an error when empty
      # No reason given
      Failure/Error: expect { @game.guess('') }.to raise_error(ArgumentError)
        expected ArgumentError, got #<NoMethodError: undefined method `guess' for #<HangpersonGame:0x00000002debe60 @word="foobar">> with backtrace:
          # ./spec/hangperson_game_spec.rb:78:in `block (5 levels) in <top (required)>'
          # ./spec/hangperson_game_spec.rb:78:in `block (4 levels) in <top (required)>'
      # ./spec/hangperson_game_spec.rb:78:in `block (4 levels) in <top (required)>'

  11) HangpersonGame guessing invalid throws an error when not a letter
      # No reason given
      Failure/Error: expect { @game.guess('%') }.to raise_error(ArgumentError)
        expected ArgumentError, got #<NoMethodError: undefined method `guess' for #<HangpersonGame:0x000000029875b8 @word="foobar">> with backtrace:
          # ./spec/hangperson_game_spec.rb:81:in `block (5 levels) in <top (required)>'
          # ./spec/hangperson_game_spec.rb:81:in `block (4 levels) in <top (required)>'
      # ./spec/hangperson_game_spec.rb:81:in `block (4 levels) in <top (required)>'

  12) HangpersonGame guessing invalid throws an error when nil
      # No reason given
      Failure/Error: expect { @game.guess(nil) }.to raise_error(ArgumentError)
        expected ArgumentError, got #<NoMethodError: undefined method `guess' for #<HangpersonGame:0x00000002975138 @word="foobar">> with backtrace:
          # ./spec/hangperson_game_spec.rb:84:in `block (5 levels) in <top (required)>'
          # ./spec/hangperson_game_spec.rb:84:in `block (4 levels) in <top (required)>'
      # ./spec/hangperson_game_spec.rb:84:in `block (4 levels) in <top (required)>'

  13) HangpersonGame displayed word with guesses should be 'b-n-n-' when guesses are 'bn'
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x00000002964e28 @word="banana">
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:101:in `block (4 levels) in <top (required)>'

  14) HangpersonGame displayed word with guesses should be '------' when guesses are 'def'
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x0000000295e140 @word="banana">
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:101:in `block (4 levels) in <top (required)>'

  15) HangpersonGame displayed word with guesses should be 'banana' when guesses are 'ban'
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x0000000295b2b0 @word="banana">
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:101:in `block (4 levels) in <top (required)>'

  16) HangpersonGame game status should be win when all letters guessed
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x0000000294fbe0 @word="dog">
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:112:in `block (3 levels) in <top (required)>'

  17) HangpersonGame game status should be lose after 7 incorrect guesses
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x0000000294c828 @word="dog">
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:116:in `block (3 levels) in <top (required)>'

  18) HangpersonGame game status should continue play if neither win nor lose
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x00000002949268 @word="dog">
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:120:in `block (3 levels) in <top (required)>'

Finished in 0.17384 seconds (files took 1.59 seconds to load)
18 examples, 0 failures, 18 pending
```

If we then follow the instructions and delete the following segment from line 12 of the hang person spec:

```
, :pending => true
```

we should see the following:

```sh
"/usr/local/rvm/rubies/ruby-2.3.0/bin/ruby" -rrubygems -S "/usr/local/rvm/gems/ruby-2.3.0/gems/rspec-core-3.3.2/exe/rspec" --tty "/home/ubuntu/workspace/hw-sinatra-saas-hangperson/spec/hangperson_game_spec.rb"

HangpersonGame
  new
    takes a parameter and returns a HangpersonGame object (FAILED - 1)
  guessing
    correctly
      changes correct guess list (PENDING: No reason given)
      returns true (PENDING: No reason given)
    incorrectly
      changes wrong guess list (PENDING: No reason given)
      returns true (PENDING: No reason given)
    same letter repeatedly
      does not change correct guess list (PENDING: No reason given)
      does not change wrong guess list (PENDING: No reason given)
      returns false (PENDING: No reason given)
      is case insensitive (PENDING: No reason given)
    invalid
      throws an error when empty (PENDING: No reason given)
      throws an error when not a letter (PENDING: No reason given)
      throws an error when nil (PENDING: No reason given)
  displayed word with guesses
    should be 'b-n-n-' when guesses are 'bn' (PENDING: No reason given)
    should be '------' when guesses are 'def' (PENDING: No reason given)
    should be 'banana' when guesses are 'ban' (PENDING: No reason given)
  game status
    should be win when all letters guessed (PENDING: No reason given)
    should be lose after 7 incorrect guesses (PENDING: No reason given)
    should continue play if neither win nor lose (PENDING: No reason given)

Pending: (Failures listed here are expected and do not affect your suite's status)

  1) HangpersonGame guessing correctly changes correct guess list
     # No reason given
     Failure/Error: @valid = @game.guess('a')
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000002eb40e0 @word="garply">
     # ./spec/hangperson_game_spec.rb:26:in `block (4 levels) in <top (required)>'

  2) HangpersonGame guessing correctly returns true
     # No reason given
     Failure/Error: @valid = @game.guess('a')
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000002f08320 @word="garply">
     # ./spec/hangperson_game_spec.rb:26:in `block (4 levels) in <top (required)>'

  3) HangpersonGame guessing incorrectly changes wrong guess list
     # No reason given
     Failure/Error: @valid = @game.guess('z')
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000002f94c30 @word="garply">
     # ./spec/hangperson_game_spec.rb:39:in `block (4 levels) in <top (required)>'

  4) HangpersonGame guessing incorrectly returns true
     # No reason given
     Failure/Error: @valid = @game.guess('z')
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000002f1bc40 @word="garply">
     # ./spec/hangperson_game_spec.rb:39:in `block (4 levels) in <top (required)>'

  5) HangpersonGame guessing same letter repeatedly does not change correct guess list
     # No reason given
     Failure/Error: game.guess(letter)
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000002fabf20 @word="garply">
     # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
     # ./spec/hangperson_game_spec.rb:7:in `chars'
     # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
     # ./spec/hangperson_game_spec.rb:52:in `block (4 levels) in <top (required)>'

  6) HangpersonGame guessing same letter repeatedly does not change wrong guess list
     # No reason given
     Failure/Error: game.guess(letter)
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000002fa8960 @word="garply">
     # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
     # ./spec/hangperson_game_spec.rb:7:in `chars'
     # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
     # ./spec/hangperson_game_spec.rb:52:in `block (4 levels) in <top (required)>'

  7) HangpersonGame guessing same letter repeatedly returns false
     # No reason given
     Failure/Error: game.guess(letter)
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000002fe07e8 @word="garply">
     # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
     # ./spec/hangperson_game_spec.rb:7:in `chars'
     # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
     # ./spec/hangperson_game_spec.rb:52:in `block (4 levels) in <top (required)>'

  8) HangpersonGame guessing same letter repeatedly is case insensitive
     # No reason given
     Failure/Error: game.guess(letter)
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000002fcd760 @word="garply">
     # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
     # ./spec/hangperson_game_spec.rb:7:in `chars'
     # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
     # ./spec/hangperson_game_spec.rb:52:in `block (4 levels) in <top (required)>'

  9) HangpersonGame guessing invalid throws an error when empty
     # No reason given
     Failure/Error: expect { @game.guess('') }.to raise_error(ArgumentError)
       expected ArgumentError, got #<NoMethodError: undefined method `guess' for #<HangpersonGame:0x00000003000930 @word="foobar">> with backtrace:
         # ./spec/hangperson_game_spec.rb:78:in `block (5 levels) in <top (required)>'
         # ./spec/hangperson_game_spec.rb:78:in `block (4 levels) in <top (required)>'
     # ./spec/hangperson_game_spec.rb:78:in `block (4 levels) in <top (required)>'

  10) HangpersonGame guessing invalid throws an error when not a letter
      # No reason given
      Failure/Error: expect { @game.guess('%') }.to raise_error(ArgumentError)
        expected ArgumentError, got #<NoMethodError: undefined method `guess' for #<HangpersonGame:0x000000034fb700 @word="foobar">> with backtrace:
          # ./spec/hangperson_game_spec.rb:81:in `block (5 levels) in <top (required)>'
          # ./spec/hangperson_game_spec.rb:81:in `block (4 levels) in <top (required)>'
      # ./spec/hangperson_game_spec.rb:81:in `block (4 levels) in <top (required)>'

  11) HangpersonGame guessing invalid throws an error when nil
      # No reason given
      Failure/Error: expect { @game.guess(nil) }.to raise_error(ArgumentError)
        expected ArgumentError, got #<NoMethodError: undefined method `guess' for #<HangpersonGame:0x0000000350b510 @word="foobar">> with backtrace:
          # ./spec/hangperson_game_spec.rb:84:in `block (5 levels) in <top (required)>'
          # ./spec/hangperson_game_spec.rb:84:in `block (4 levels) in <top (required)>'
      # ./spec/hangperson_game_spec.rb:84:in `block (4 levels) in <top (required)>'

  12) HangpersonGame displayed word with guesses should be 'b-n-n-' when guesses are 'bn'
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x0000000354f058 @word="banana">
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:101:in `block (4 levels) in <top (required)>'

  13) HangpersonGame displayed word with guesses should be '------' when guesses are 'def'
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x00000003537d18 @word="banana">
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:101:in `block (4 levels) in <top (required)>'

  14) HangpersonGame displayed word with guesses should be 'banana' when guesses are 'ban'
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x000000035353b0 @word="banana">
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:101:in `block (4 levels) in <top (required)>'

  15) HangpersonGame game status should be win when all letters guessed
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x000000035897d0 @word="dog">
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:112:in `block (3 levels) in <top (required)>'

  16) HangpersonGame game status should be lose after 7 incorrect guesses
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x000000035731b0 @word="dog">
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:116:in `block (3 levels) in <top (required)>'

  17) HangpersonGame game status should continue play if neither win nor lose
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x00000003570618 @word="dog">
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:120:in `block (3 levels) in <top (required)>'

Failures:

  1) HangpersonGame new takes a parameter and returns a HangpersonGame object
     Failure/Error: expect(@hangpersonGame.word).to eq('glorp')
     NoMethodError:
       undefined method `word' for #<HangpersonGame:0x00000002ec2410 @word="glorp">
     # ./spec/hangperson_game_spec.rb:16:in `block (3 levels) in <top (required)>'

Finished in 0.04773 seconds (files took 0.82283 seconds to load)
18 examples, 1 failure, 17 pending

Failed examples:

rspec ./spec/hangperson_game_spec.rb:13 # HangpersonGame new takes a parameter and returns a HangpersonGame object
```


Now I (Sam) am not the biggest fan of auto test, since I find it unreliable, and I also worry that pedagogically we are hitting the students with reams and reams of output here, and I would much rather get the students into the habit of running the individual tests with commands like:

```sh
bundle exec rspec ./spec/hangperson_game_spec.rb:13
```

and getting them into the habit of running the main `rspec` on ever increasing sets of tests so that they are taking more executive control of the testing process, but each to their own. 

So now the students are expected to try out the two self-check tests in order to understand how to proceed and make the failing test pass.

We can follow the suggestion to add `attr_accessors` to the `lib/hangperson` class as follows:

  
```rb
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
```

although it's not the only way, and we might feel that using `attr_accessor` is a bit of a code smell as discussed in the following links:


http://solnic.eu/2012/04/04/get-rid-of-that-code-smell-attributes.html
https://www.reddit.com/r/ruby/comments/rv4yo/get_rid_of_that_code_smell_attributes/
https://github.com/troessner/reek/blob/master/docs/Attribute.md

Note also that the self-check question about instance variables it not actually correct in that the tests are not specifying the hangperson class has instance variables, they are specifying that they have certain instance methods available, so in fact adding `attr_accessor` methods here is breaking the rule of only ever do the absolute minimum to make tests pass.  Perhaps I'm being overly pedantic here, but there is no need to make instance variables to make these tests pass.  The tests will move on in exactly the same way with the following code:

```rb
  def word
    @word
  end
  def guesses
  end
  def wrong_guesses
  end
```

or

```rb
  attr_reader :word
  attr_reader :guesses
  attr_reader :wrong_guesses
```

I guess it all depends what we want the students to be focusing on here.  Is is the nice ruby shorthand with `attr_accessor` (or `attr_reader`) or is it how to ensure to respond to test failures with minimum changes and to understand the side-effects of what they are doing and how they are affecting the encapsulation of the class under study here.

Here we also see that the operation of `autotest` with all the pending tests makes it onerous to compare one test error to the next, which would be must easier if we were running `bundle exec rspec ./spec/hangperson_game_spec.rb:13`.


However you make the change, the tests won't pass immediately - you'll get this new error:

```
Failures:

  1) HangpersonGame new takes a parameter and returns a HangpersonGame object
     Failure/Error: expect(@hangpersonGame.guesses).to eq('')
       
       expected: ""
            got: nil
       
       (compared using ==)
     # ./spec/hangperson_game_spec.rb:17:in `block (3 levels) in <top (required)>'

Finished in 0.04544 seconds (files took 1.18 seconds to load)
18 examples, 1 failure, 17 pending

Failed examples:

rspec ./spec/hangperson_game_spec.rb:13 # HangpersonGame new takes a parameter and returns a HangpersonGame object
```

This is because by default the "getter" specified by attr_reader or attr_accessor will return a nil rather than the expected empty string.  If we've used attr_'s we'll need to set the default response in the constructor.  If we've created explicit methods we can set a default value there and avoid instance variables.  Of course since we're being told to create instance variables it makes sense to follow that advice.

If we adjust the constructor like so:

```rb
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end
```

we should see the test pass, although it is heavily obscured by all the pending tests:

```
HangpersonGame
  new
    takes a parameter and returns a HangpersonGame object
  guessing
    correctly
      changes correct guess list (PENDING: No reason given)
      returns true (PENDING: No reason given)
    incorrectly
      changes wrong guess list (PENDING: No reason given)
      returns true (PENDING: No reason given)
    same letter repeatedly
      does not change correct guess list (PENDING: No reason given)
      does not change wrong guess list (PENDING: No reason given)
      returns false (PENDING: No reason given)
      is case insensitive (PENDING: No reason given)
    invalid
      throws an error when empty (PENDING: No reason given)
      throws an error when not a letter (PENDING: No reason given)
      throws an error when nil (PENDING: No reason given)
  displayed word with guesses
    should be 'b-n-n-' when guesses are 'bn' (PENDING: No reason given)
    should be '------' when guesses are 'def' (PENDING: No reason given)
    should be 'banana' when guesses are 'ban' (PENDING: No reason given)
  game status
    should be win when all letters guessed (PENDING: No reason given)
    should be lose after 7 incorrect guesses (PENDING: No reason given)
    should continue play if neither win nor lose (PENDING: No reason given)

Pending: (Failures listed here are expected and do not affect your suite's status)

  1) HangpersonGame guessing correctly changes correct guess list
     # No reason given
     Failure/Error: @valid = @game.guess('a')
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000003516398>
       Did you mean?  guesses
     # ./spec/hangperson_game_spec.rb:26:in `block (4 levels) in <top (required)>'

  2) HangpersonGame guessing correctly returns true
     # No reason given
     Failure/Error: @valid = @game.guess('a')
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000003513af8>
       Did you mean?  guesses
     # ./spec/hangperson_game_spec.rb:26:in `block (4 levels) in <top (required)>'

  3) HangpersonGame guessing incorrectly changes wrong guess list
     # No reason given
     Failure/Error: @valid = @game.guess('z')
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000003510358>
       Did you mean?  guesses
     # ./spec/hangperson_game_spec.rb:39:in `block (4 levels) in <top (required)>'

  4) HangpersonGame guessing incorrectly returns true
     # No reason given
     Failure/Error: @valid = @game.guess('z')
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000003505728>
       Did you mean?  guesses
     # ./spec/hangperson_game_spec.rb:39:in `block (4 levels) in <top (required)>'

  5) HangpersonGame guessing same letter repeatedly does not change correct guess list
     # No reason given
     Failure/Error: game.guess(letter)
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x00000003501ee8>
       Did you mean?  guesses
     # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
     # ./spec/hangperson_game_spec.rb:7:in `chars'
     # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
     # ./spec/hangperson_game_spec.rb:52:in `block (4 levels) in <top (required)>'

  6) HangpersonGame guessing same letter repeatedly does not change wrong guess list
     # No reason given
     Failure/Error: game.guess(letter)
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x000000034fa8a0>
       Did you mean?  guesses
     # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
     # ./spec/hangperson_game_spec.rb:7:in `chars'
     # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
     # ./spec/hangperson_game_spec.rb:52:in `block (4 levels) in <top (required)>'

  7) HangpersonGame guessing same letter repeatedly returns false
     # No reason given
     Failure/Error: game.guess(letter)
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x000000034efb58>
       Did you mean?  guesses
     # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
     # ./spec/hangperson_game_spec.rb:7:in `chars'
     # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
     # ./spec/hangperson_game_spec.rb:52:in `block (4 levels) in <top (required)>'

  8) HangpersonGame guessing same letter repeatedly is case insensitive
     # No reason given
     Failure/Error: game.guess(letter)
     NoMethodError:
       undefined method `guess' for #<HangpersonGame:0x000000034ec2c8>
       Did you mean?  guesses
     # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
     # ./spec/hangperson_game_spec.rb:7:in `chars'
     # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
     # ./spec/hangperson_game_spec.rb:52:in `block (4 levels) in <top (required)>'

  9) HangpersonGame guessing invalid throws an error when empty
     # No reason given
     Failure/Error: expect { @game.guess('') }.to raise_error(ArgumentError)
       expected ArgumentError, got #<NoMethodError: undefined method `guess' for #<HangpersonGame:0x000000034e4c08>
       Did you mean?  guesses> with backtrace:
         # ./spec/hangperson_game_spec.rb:78:in `block (5 levels) in <top (required)>'
         # ./spec/hangperson_game_spec.rb:78:in `block (4 levels) in <top (required)>'
     # ./spec/hangperson_game_spec.rb:78:in `block (4 levels) in <top (required)>'

  10) HangpersonGame guessing invalid throws an error when not a letter
      # No reason given
      Failure/Error: expect { @game.guess('%') }.to raise_error(ArgumentError)
        expected ArgumentError, got #<NoMethodError: undefined method `guess' for #<HangpersonGame:0x0000000307b7e8>
        Did you mean?  guesses> with backtrace:
          # ./spec/hangperson_game_spec.rb:81:in `block (5 levels) in <top (required)>'
          # ./spec/hangperson_game_spec.rb:81:in `block (4 levels) in <top (required)>'
      # ./spec/hangperson_game_spec.rb:81:in `block (4 levels) in <top (required)>'

  11) HangpersonGame guessing invalid throws an error when nil
      # No reason given
      Failure/Error: expect { @game.guess(nil) }.to raise_error(ArgumentError)
        expected ArgumentError, got #<NoMethodError: undefined method `guess' for #<HangpersonGame:0x0000000306d3a0>
        Did you mean?  guesses> with backtrace:
          # ./spec/hangperson_game_spec.rb:84:in `block (5 levels) in <top (required)>'
          # ./spec/hangperson_game_spec.rb:84:in `block (4 levels) in <top (required)>'
      # ./spec/hangperson_game_spec.rb:84:in `block (4 levels) in <top (required)>'

  12) HangpersonGame displayed word with guesses should be 'b-n-n-' when guesses are 'bn'
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x00000003058180>
        Did you mean?  guesses
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:101:in `block (4 levels) in <top (required)>'

  13) HangpersonGame displayed word with guesses should be '------' when guesses are 'def'
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x000000030552f0>
        Did you mean?  guesses
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:101:in `block (4 levels) in <top (required)>'

  14) HangpersonGame displayed word with guesses should be 'banana' when guesses are 'ban'
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x0000000304e9a0>
        Did you mean?  guesses
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:101:in `block (4 levels) in <top (required)>'

  15) HangpersonGame game status should be win when all letters guessed
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x00000003046520>
        Did you mean?  guesses
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:112:in `block (3 levels) in <top (required)>'

  16) HangpersonGame game status should be lose after 7 incorrect guesses
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x000000030435a0>
        Did you mean?  guesses
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:116:in `block (3 levels) in <top (required)>'

  17) HangpersonGame game status should continue play if neither win nor lose
      # No reason given
      Failure/Error: game.guess(letter)
      NoMethodError:
        undefined method `guess' for #<HangpersonGame:0x00000003040440>
        Did you mean?  guesses
      # ./spec/hangperson_game_spec.rb:8:in `block in guess_several_letters'
      # ./spec/hangperson_game_spec.rb:7:in `chars'
      # ./spec/hangperson_game_spec.rb:7:in `guess_several_letters'
      # ./spec/hangperson_game_spec.rb:120:in `block (3 levels) in <top (required)>'

Finished in 0.03449 seconds (files took 0.71381 seconds to load)
18 examples, 0 failures, 17 pending
```

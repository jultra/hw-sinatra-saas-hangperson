So we've got another chunk of background theory to read, but then we can run the app we've cloned like so:

```
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ cd hw-sinatra-saas-hangperson
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ bundle exec rerun -- rackup -p $PORT -o $IP

09:31:06 [rerun] Hw-sinatra-saas-hangperson launched
[2017-08-07 09:31:08] INFO  WEBrick 1.3.1
[2017-08-07 09:31:08] INFO  ruby 2.3.0 (2015-12-25) [x86_64-linux]
[2017-08-07 09:31:08] INFO  WEBrick::HTTPServer#start: pid=1894 port=8080
/usr/local/rvm/gems/ruby-2.3.0/gems/rerun-0.10.0/lib/rerun/watcher.rb:89:in `adapter': Object#timeout is deprecated, use Timeout.timeout instead.
09:31:09 [rerun] Watching . for **/*.{rb,js,coffee,css,scss,sass,erb,html,haml,ru,yml,slim,md} using Linux adapter
```

Following the instructions (and self-check question) we should see something like:

![](https://www.dropbox.com/s/wgldhv21dkw4y9k/Screenshot%202017-08-07%2018.33.40.png?dl=1)

and we might be tempted to click on "new game" which will lead to this error message:

![](https://www.dropbox.com/s/gjjmziyb5qgavaf/Screenshot%202017-08-07%2018.34.01.png?dl=1)

Now we can deploy to heroku as instructed.

```
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ git status
On branch master
Your branch is up-to-date with 'origin/master'.
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   lib/hangperson_game.rb
        modified:   spec/hangperson_game_spec.rb

no changes added to commit (use "git add" and/or "git commit -a")
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ git add .
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ git commit -m 'ready for heroku!'
[master 520023e] ready for heroku!
 2 files changed, 56 insertions(+), 18 deletions(-)
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ heroku login
Enter your Heroku credentials:
Email: tansaku+c9test@gmail.com
Password: ************
Logged in as tansaku+c9test@gmail.com
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ heroku create hangperson-clean2017
Creating ⬢ hangperson-clean2017... done
https://hangperson-clean2017.herokuapp.com/ | https://git.heroku.com/hangperson-clean2017.git
```

```
c9testaduror:~/workspace/hw-sinatra-saas-hangperson (master) $ git push heroku master
Counting objects: 346, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (159/159), done.
Writing objects: 100% (346/346), 156.96 KiB | 0 bytes/s, done.
Total 346 (delta 180), reused 334 (delta 175)
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
remote:        Fetching rack 1.6.4
remote:        Fetching tilt 2.0.5
remote:        Installing tilt 2.0.5
remote:        Installing rack 1.6.4
remote:        Fetching rack-protection 1.5.3
remote:        Installing rack-protection 1.5.3
remote:        Fetching sinatra 1.4.7
remote:        Installing sinatra 1.4.7
remote:        Fetching sinatra-flash 0.3.0
remote:        Installing sinatra-flash 0.3.0
remote:        Bundle complete! 15 Gemfile dependencies, 6 gems now installed.
remote:        Gems in the groups development and test were not installed.
remote:        Bundled gems are installed into ./vendor/bundle.
remote:        Bundle completed (2.02s)
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
remote:        Released v4
remote:        https://hangperson-clean2017.herokuapp.com/ deployed to Heroku
remote: 
remote: Verifying deploy... done.
To https://git.heroku.com/hangperson-clean2017.git
 * [new branch]      master -> master
```

and note how the error on heroku is displayed a little differently:

![](https://www.dropbox.com/s/2mpf72lfpo7pkt1/Screenshot%202017-08-07%2018.42.47.png?dl=1)

because the app is in production mode by default on heroku, rather than development mode on c9



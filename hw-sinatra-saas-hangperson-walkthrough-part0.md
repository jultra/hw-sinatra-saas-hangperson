We can follow the initial instructions in "Part 0: Demystifying SaaS app creation" with these commands:

```sh
tansaku:~/workspace/hello_sinatra (master) $ mkdir hello_sinatra
tansaku:~/workspace/hello_sinatra (master) $ cd hello_sinatra
tansaku:~/workspace/hello_sinatra (master) $ git init
Initialized empty Git repository in /home/ubuntu/workspace/hello_sinatra/.git/
tansaku:~/workspace/hello_sinatra (master) $ touch Gemfile # or `bundle init`
```

and then we put the specified contents in the Gemfile and run bundle:

```sh
tansaku:~/workspace/hello_sinatra (master) $ gem install bundler
Fetching: bundler-1.15.3.gem (100%)
Successfully installed bundler-1.15.3
1 gem installed
tansaku:~/workspace/hello_sinatra (master) $ bundle
Fetching gem metadata from https://rubygems.org/..........
Fetching version metadata from https://rubygems.org/.
Resolving dependencies...
Using bundler 1.15.3
Fetching mustermann 1.0.0
Installing mustermann 1.0.0
Fetching rack 2.0.3
Installing rack 2.0.3
Fetching tilt 2.0.8
Installing tilt 2.0.8
Fetching rack-protection 2.0.0
Installing rack-protection 2.0.0
Fetching sinatra 2.0.0
Installing sinatra 2.0.0
Bundle complete! 1 Gemfile dependency, 6 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

We may need to use `gem install bundler` if the bundle gem is not currently on our system.   Then we can add our files to version control as specified:

```sh
tansaku:~/workspace/hello_sinatra (master) $ git add .
tansaku:~/workspace/hello_sinatra (master) $ git commit -m 'Set up the Gemfile'
[master (root-commit) eeee73a] Set up the Gemfile
 2 files changed, 29 insertions(+)
 create mode 100644 Gemfile
 create mode 100644 Gemfile.lock
```

We create the `app.rb` and `config.ru` files as specified, add the contents indicated in the instructions, and add to version control:

```sh
tansaku:~/workspace/hello_sinatra (master) $ touch app.rb
tansaku:~/workspace/hello_sinatra (master) $ touch config.ru
tansaku:~/workspace/hello_sinatra (master) $ git add .
tansaku:~/workspace/hello_sinatra (master) $ git commit -m 'adds app.rb and config.ru files'
[master 0dd416c] adds app.rb and config.ru files
 2 files changed, 9 insertions(+)
 create mode 100644 app.rb
 create mode 100644 config.ru
```

We can now run the server on cloud 9:

```sh
tansaku:~/workspace/hello_sinatra (master) $ bundle exec rackup -p $PORT -o $IP
[2017-07-29 09:04:07] INFO  WEBrick 1.3.1
[2017-07-29 09:04:07] INFO  ruby 2.3.0 (2015-12-25) [x86_64-linux]
[2017-07-29 09:04:07] INFO  WEBrick::HTTPServer#start: pid=2222 port=8080
```

and cloud 9 will tell us the URL we can go to to see the running app:

![Cloud9 Help: Your code is running at URL message](https://www.dropbox.com/s/7jr3cj4u9a5ff8w/Screenshot%202017-07-29%2018.02.01.png?dl=1)

It should look like this:

![Hello World message from Sinatra](https://www.dropbox.com/s/p14uwn22vkhr6jf/Screenshot%202017-07-29%2018.03.24.png?dl=1)

After you've clicked through on a message about how this is an application preview:

![This is the preview of an application being developed with Cloud9 IDE](https://www.dropbox.com/s/n5dy9ircx0ua0q9/Screenshot%202017-07-29%2018.04.36.png?dl=1)

As we proceed to follow the instructions we'll see the live log from the server displayed in the terminal shell:

```sh
133.202.198.78 - - [29/Jul/2017:09:04:10 +0000] "GET / HTTP/1.1" 200 74 0.0131
133.202.198.78 - - [29/Jul/2017:09:04:32 +0000] "GET /favicon.ico HTTP/1.1" 404 533 0.0012
133.202.198.78 - - [29/Jul/2017:09:07:04 +0000] "GET /hello HTTP/1.1" 404 527 0.0010
133.202.198.78 - - [29/Jul/2017:09:07:05 +0000] "GET /__sinatra__/404.png HTTP/1.1" 200 18893 0.0039
133.202.198.78 - - [29/Jul/2017:09:08:28 +0000] "GET / HTTP/1.1" 200 74 0.0009
```

We'll have to quite the app with Ctrl-C and restart to see any changes to our app.rb file:

```sh
^C[2017-07-29 09:10:48] INFO  going to shutdown ...
[2017-07-29 09:10:48] INFO  WEBrick::HTTPServer#start done.
tansaku:~/workspace/hello_sinatra (master) $ bundle exec rackup -p $PORT -o $IP
[2017-07-29 09:10:52] INFO  WEBrick 1.3.1
[2017-07-29 09:10:52] INFO  ruby 2.3.0 (2015-12-25) [x86_64-linux]
[2017-07-29 09:10:52] INFO  WEBrick::HTTPServer#start: pid=2253 port=8080
```

Now you should see any changes you made to app.rb, such as "Goodbye World".  The instructions now tell you to add the rerun gem to the Gemfile and re-run the server with a different command.  If you can remember how to shut down the server (Ctrl-c) you might get the following message:

```sh
^C[2017-07-29 09:13:52] INFO  going to shutdown ...
[2017-07-29 09:13:52] INFO  WEBrick::HTTPServer#start done.
tansaku:~/workspace/hello_sinatra (master) $ bundle exec rerun -- rackup -p $PORT -o $IP
bundler: command not found: rerun
Install missing gem executables with `bundle install`
```

Note that `bundle` is short for `bundle install` - they are equivalent - use the former if you prefer to type less:

```sh
tansaku:~/workspace/hello_sinatra (master) $ bundle
Fetching gem metadata from https://rubygems.org/...........
Fetching version metadata from https://rubygems.org/..
Fetching dependency metadata from https://rubygems.org/.
Resolving dependencies...
Using bundler 1.15.3
Fetching ffi 1.9.18
Installing ffi 1.9.18 with native extensions
Fetching rb-fsevent 0.10.2
Installing rb-fsevent 0.10.2
Fetching ruby_dep 1.5.0
Installing ruby_dep 1.5.0
Using mustermann 1.0.0
Using rack 2.0.3
Using tilt 2.0.8
Fetching rb-inotify 0.9.10
Installing rb-inotify 0.9.10
Using rack-protection 2.0.0
Fetching listen 3.1.5
Installing listen 3.1.5
Using sinatra 2.0.0
Fetching rerun 0.11.0
Installing rerun 0.11.0
Bundle complete! 2 Gemfile dependencies, 12 gems now installed.
Use `bundle info [gemname]` to see where a bundled gem is installed.
```

Now we can use rerun:

```sh
tansaku:~/workspace/hello_sinatra (master) $ bundle exec rerun -- rackup -p $PORT -o $IP              
RubyDep: WARNING: Your Ruby is outdated/buggy.
RubyDep: WARNING: Your Ruby is: 2.3.0 (buggy). Recommendation: upgrade to 2.3.1.
RubyDep: WARNING: (To disable warnings, see:http://github.com/e2/ruby_dep/wiki/Disabling-warnings )

09:16:55 [rerun] Hello_sinatra launched
[2017-07-29 09:16:56] INFO  WEBrick 1.3.1
[2017-07-29 09:16:56] INFO  ruby 2.3.0 (2015-12-25) [x86_64-linux]
[2017-07-29 09:16:56] INFO  WEBrick::HTTPServer#start: pid=2653 port=8080
09:16:57 [rerun] Watching . for **/*.{rb,js,coffee,css,scss,sass,erb,html,haml,ru,yml,slim,md,feature}
```

We should be using a more recent version of ruby, but will need to wait for Cloud9 to update ... :-(

Anyhow, with rerun in operation we can check that changes to app.rb are immediately available.  And our terminal output will look something like this:


```sh
09:17:55 [rerun] Change detected: 1 modified: app.rb
/usr/local/rvm/gems/ruby-2.3.0/gems/rerun-0.11.0/lib/rerun/runner.rb:254:in `stop': Object#timeout is deprecated, use Timeout.timeout instead.
09:17:55 [rerun] Sending signal TERM to 2653
[2017-07-29 09:17:55] FATAL SignalException: SIGTERM
        /usr/local/rvm/rubies/ruby-2.3.0/lib/ruby/2.3.0/webrick/server.rb:177:in `select'
        /usr/local/rvm/rubies/ruby-2.3.0/lib/ruby/2.3.0/webrick/server.rb:177:in `block in start'
        /usr/local/rvm/rubies/ruby-2.3.0/lib/ruby/2.3.0/webrick/server.rb:33:in `start'
        /usr/local/rvm/rubies/ruby-2.3.0/lib/ruby/2.3.0/webrick/server.rb:164:in `start'
        /usr/local/rvm/gems/ruby-2.3.0/gems/rack-2.0.3/lib/rack/handler/webrick.rb:34:in `run'
        /usr/local/rvm/gems/ruby-2.3.0/gems/rack-2.0.3/lib/rack/server.rb:297:in `start'
        /usr/local/rvm/gems/ruby-2.3.0/gems/rack-2.0.3/lib/rack/server.rb:148:in `start'
        /usr/local/rvm/gems/ruby-2.3.0/gems/rack-2.0.3/bin/rackup:4:in `<top (required)>'
        /usr/local/rvm/gems/ruby-2.3.0/bin/rackup:23:in `load'
        /usr/local/rvm/gems/ruby-2.3.0/bin/rackup:23:in `<main>'
        /usr/local/rvm/gems/ruby-2.3.0/bin/ruby_executable_hooks:15:in `eval'
        /usr/local/rvm/gems/ruby-2.3.0/bin/ruby_executable_hooks:15:in `<main>'
[2017-07-29 09:17:55] INFO  going to shutdown ...
[2017-07-29 09:17:55] INFO  WEBrick::HTTPServer#start done.

09:17:55 [rerun] Hello_sinatra restarted
[2017-07-29 09:17:55] INFO  WEBrick 1.3.1
[2017-07-29 09:17:55] INFO  ruby 2.3.0 (2015-12-25) [x86_64-linux]
[2017-07-29 09:17:55] INFO  WEBrick::HTTPServer#start: pid=2792 port=8080
133.202.198.78 - - [29/Jul/2017:09:17:57 +0000] "GET / HTTP/1.1" 200 74 0.0120
```

To commit out latest changes to git we can use the following commands:

```
^C
09:24:59 [rerun] Hello_sinatra stopping
[2017-07-29 09:24:59] INFO  going to shutdown ...
/usr/local/rvm/gems/ruby-2.3.0/gems/rerun-0.11.0/lib/rerun/runner.rb:254:in `stop': Object#timeout is deprecated, use Timeout.timeout instead.
[2017-07-29 09:24:59] INFO  WEBrick::HTTPServer#start done.
09:24:59 [rerun] Sending signal TERM to 3013
tansaku:~/workspace/hello_sinatra (master) $ git status
On branch master
Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working directory)

        modified:   Gemfile
        modified:   Gemfile.lock

no changes added to commit (use "git add" and/or "git commit -a")
tansaku:~/workspace/hello_sinatra (master) $ git add .
tansaku:~/workspace/hello_sinatra (master) $ git commit -m 'adds rerun gem'
[master 6458fb5] adds rerun gem
 2 files changed, 17 insertions(+), 1 deletion(-)
```

`git status` just allows us to check what has changed since we last committed.


We can then update the heroku toolbelt as specified:

```sh
tansaku:~/workspace/hello_sinatra (master) $ heroku --version
heroku-toolbelt/3.43.13 (x86_64-linux) ruby/2.3.0
heroku-cli/5.4.8-eee5ec9 (linux-amd64) go1.7.1
You have no installed plugins.
tansaku:~/workspace/hello_sinatra (master) $ wget -O- https://toolbelt.heroku.com/install-ubuntu.sh | sh
--2017-07-29 09:29:46--  https://toolbelt.heroku.com/install-ubuntu.sh
Resolving toolbelt.heroku.com (toolbelt.heroku.com)... 23.21.108.35, 54.243.118.8, 54.243.150.141
Connecting to toolbelt.heroku.com (toolbelt.heroku.com)|23.21.108.35|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 719 [text/plain]
Saving to: ‘STDOUT’

100%[============================================================>] 719         --.-K/s   in 0s      

2017-07-29 09:29:46 (130 MB/s) - written to stdout [719/719]

This script requires superuser access to install apt packages.
You will be prompted for your password by sudo.
--2017-07-29 09:29:47--  https://toolbelt.heroku.com/apt/release.key
Resolving toolbelt.heroku.com (toolbelt.heroku.com)... 54.243.150.141, 54.243.118.8, 23.21.108.35
Connecting to toolbelt.heroku.com (toolbelt.heroku.com)|54.243.150.141|:443... connected.
HTTP request sent, awaiting response... 200 OK
Length: 1737 (1.7K) [application/octet-stream]
Saving to: ‘STDOUT’

100%[============================================================>] 1,737       --.-K/s   in 0s      

2017-07-29 09:29:47 (321 MB/s) - written to stdout [1737/1737]

OK
Get:1 http://ppa.launchpad.net trusty InRelease [15.5 kB]
Get:2 http://security.ubuntu.com trusty-security InRelease [65.9 kB]           
Ign http://europe-west1.gce.clouds.archive.ubuntu.com trusty InRelease         
Get:3 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-updates InRelease [65.9 kB]
Get:4 http://ppa.launchpad.net trusty InRelease [15.4 kB]                      
Ign http://downloads-distro.mongodb.org dist InRelease                         
Get:5 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-backports InRelease [65.9 kB]
Get:6 http://ppa.launchpad.net trusty/main amd64 Packages [23.2 kB]            
Ign http://toolbelt.heroku.com ./ InRelease                                    
Get:7 http://europe-west1.gce.clouds.archive.ubuntu.com trusty Release.gpg [933 B]
Hit http://downloads-distro.mongodb.org dist Release.gpg                       
Get:8 http://ppa.launchpad.net trusty/main i386 Packages [23.2 kB]             
Get:9 http://security.ubuntu.com trusty-security/main Sources [175 kB]         
Get:10 http://security.ubuntu.com trusty-security/universe Sources [72.1 kB]   
Get:11 http://security.ubuntu.com trusty-security/main amd64 Packages [799 kB] 
Get:12 http://europe-west1.gce.clouds.archive.ubuntu.com trusty Release [58.5 kB]
Get:13 http://security.ubuntu.com trusty-security/universe amd64 Packages [228 kB]
Get:14 http://security.ubuntu.com trusty-security/main i386 Packages [740 kB]  
Get:15 http://toolbelt.heroku.com ./ Release.gpg [473 B]                       
Hit http://downloads-distro.mongodb.org dist Release                           
Get:16 http://security.ubuntu.com trusty-security/universe i386 Packages [229 kB]
Get:17 http://ppa.launchpad.net trusty/main amd64 Packages [3427 B]            
Get:18 http://ppa.launchpad.net trusty/main i386 Packages [3427 B]             
Get:19 http://toolbelt.heroku.com ./ Release [1609 B]                     
Get:20 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-updates/main Sources [495 kB]
Hit http://downloads-distro.mongodb.org dist/10gen amd64 Packages              
Get:21 http://toolbelt.heroku.com ./ Packages [636 B]               
Get:22 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-updates/restricted Sources [6470 B]
Get:23 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-updates/universe Sources [235 kB]
Hit http://downloads-distro.mongodb.org dist/10gen i386 Packages               
Get:24 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-updates/multiverse Sources [7661 B]
Get:25 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-updates/main amd64 Packages [1249 kB]
Get:26 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-updates/restricted amd64 Packages [21.2 kB]
Get:27 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-updates/universe amd64 Packages [541 kB]
Get:28 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-updates/multiverse amd64 Packages [15.6 kB]
Get:29 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-updates/main i386 Packages [1188 kB]
Get:30 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-updates/restricted i386 Packages [20.9 kB]
Get:31 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-updates/universe i386 Packages [543 kB]
Get:32 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-updates/multiverse i386 Packages [16.1 kB]
Get:33 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-backports/main Sources [10.4 kB]
Get:34 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-backports/restricted Sources [40 B]
Get:35 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-backports/universe Sources [41.2 kB]
Get:36 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-backports/multiverse Sources [1751 B]
Get:37 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-backports/main amd64 Packages [14.8 kB]
Get:38 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-backports/restricted amd64 Packages [40 B]
Get:39 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-backports/universe amd64 Packages [52.6 kB]
Get:40 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-backports/multiverse amd64 Packages [1396 B]
Get:41 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-backports/main i386 Packages [14.8 kB]
Get:42 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-backports/restricted i386 Packages [40 B]
Get:43 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-backports/universe i386 Packages [52.6 kB]
Get:44 http://europe-west1.gce.clouds.archive.ubuntu.com trusty-backports/multiverse i386 Packages [1381 B]
Get:45 http://europe-west1.gce.clouds.archive.ubuntu.com trusty/main Sources [1335 kB]
Get:46 http://europe-west1.gce.clouds.archive.ubuntu.com trusty/restricted Sources [5335 B]
Get:47 http://europe-west1.gce.clouds.archive.ubuntu.com trusty/universe Sources [7926 kB]
Get:48 http://europe-west1.gce.clouds.archive.ubuntu.com trusty/multiverse Sources [211 kB]
Get:49 http://europe-west1.gce.clouds.archive.ubuntu.com trusty/main amd64 Packages [1743 kB]
Get:50 http://europe-west1.gce.clouds.archive.ubuntu.com trusty/restricted amd64 Packages [16.0 kB]
Get:51 http://europe-west1.gce.clouds.archive.ubuntu.com trusty/universe amd64 Packages [7589 kB]
Get:52 http://europe-west1.gce.clouds.archive.ubuntu.com trusty/multiverse amd64 Packages [169 kB]
Get:53 http://europe-west1.gce.clouds.archive.ubuntu.com trusty/main i386 Packages [1739 kB]
Get:54 http://europe-west1.gce.clouds.archive.ubuntu.com trusty/restricted i386 Packages [16.4 kB]
Get:55 http://europe-west1.gce.clouds.archive.ubuntu.com trusty/universe i386 Packages [7597 kB]
Get:56 http://europe-west1.gce.clouds.archive.ubuntu.com trusty/multiverse i386 Packages [172 kB]
Fetched 35.6 MB in 8s (4093 kB/s)                                              
Reading package lists... Done
W: Size of file /var/lib/apt/lists/toolbelt.heroku.com_ubuntu_._Packages.gz is not what the server reported 636 725
Reading package lists... Done
Building dependency tree       
Reading state information... Done
The following extra packages will be installed:
  heroku
The following packages will be upgraded:
  heroku heroku-toolbelt
2 upgraded, 0 newly installed, 0 to remove and 225 not upgraded.
Need to get 1492 B of archives.
After this operation, 0 B of additional disk space will be used.
Get:1 http://toolbelt.heroku.com/ubuntu/ ./ heroku-toolbelt 3.99.4 [702 B]
Get:2 http://toolbelt.heroku.com/ubuntu/ ./ heroku 3.99.4 [790 B]
Fetched 1492 B in 0s (2218 B/s) 
(Reading database ... 74739 files and directories currently installed.)
Preparing to unpack .../heroku-toolbelt_3.99.4_all.deb ...
Unpacking heroku-toolbelt (3.99.4) over (3.43.13) ...
Preparing to unpack .../archives/heroku_3.99.4_all.deb ...
Unpacking heroku (3.99.4) over (3.43.13) ...
Setting up heroku (3.99.4) ...
+ uname -m
+ MACHINE_TYPE=x86_64
+ [ x86_64 = x86_64 ]
+ ARCH=x64
+ mkdir -p /usr/local
+ cd /usr/local
+ wget -qO- https://cli-assets.heroku.com/heroku-cli/channels/stable/heroku-cli-linux-x64.tar.gz
+ tar xz
+ rm -rf /usr/local/heroku
+ mv /usr/local/heroku-cli-v6.13.5-5be2d1f-linux-x64 /usr/local/heroku
+ ln -sf /usr/local/heroku/bin/heroku /usr/bin/heroku
Setting up heroku-toolbelt (3.99.4) ...
tansaku:~/workspace/hello_sinatra (master) $ heroku --version
heroku-cli/6.13.5-5be2d1f (linux-x64) node-v8.2.1
```

Assuming you have a heroku account you can then login as follows:

```
tansaku:~/workspace/hello_sinatra (master) $ heroku login
Enter your Heroku credentials:
Email: <YOUR EMAIL>
Password: ************
Logged in as <YOUR EMAIL>
```

You can then run heroku create:

```sh
tansaku:~/workspace/hello_sinatra (master) $ heroku create hangperson2017
Creating ⬢ hangperson2017... done
https://hangperson2017.herokuapp.com/ | https://git.heroku.com/hangperson2017.git
```

Note that if you specify a name for the app, that will become the subdomain of the URL, and might be easier for you to remember what the app was for later. 

Now we need to add the Procfile with the specified contents and commit that to git:

```sh
tansaku:~/workspace/hello_sinatra (master) $ touch Procfile
tansaku:~/workspace/hello_sinatra (master) $ git status
On branch master
Untracked files:
  (use "git add <file>..." to include in what will be committed)

        Procfile

nothing added to commit but untracked files present (use "git add" to track)
tansaku:~/workspace/hello_sinatra (master) $ git add .
tansaku:~/workspace/hello_sinatra (master) $ git commit -m 'adds Procfile'
[master b9800f4] adds Procfile
 1 file changed, 1 insertion(+)
 create mode 100644 Procfile
```


Then we can deploy to heroku:

```
tansaku:~/workspace/hello_sinatra (master) $ git push heroku master
Counting objects: 15, done.
Delta compression using up to 8 threads.
Compressing objects: 100% (13/13), done.
Writing objects: 100% (15/15), 1.64 KiB | 0 bytes/s, done.
Total 15 (delta 4), reused 0 (delta 0)
remote: Compressing source files... done.
remote: Building source:
remote: 
remote: -----> Ruby app detected
remote: -----> Compiling Ruby/Rack
remote: -----> Using Ruby version: ruby-2.3.0
remote: -----> Installing dependencies using bundler 1.15.2
remote:        Running: bundle install --without development:test --path vendor/bundle --binstubs vendor/bundle/bin -j4 --deployment
remote:        Warning: the running version of Bundler (1.15.2) is older than the version that created the lockfile (1.15.3). We suggest you upgrade to the latest version of Bundler by running `gem install bundler`.
remote:        Fetching gem metadata from https://rubygems.org/.........
remote:        Fetching version metadata from https://rubygems.org/.
remote:        Using bundler 1.15.2
remote:        Fetching mustermann 1.0.0
remote:        Fetching rack 2.0.3
remote:        Fetching tilt 2.0.8
remote:        Installing mustermann 1.0.0
remote:        Installing tilt 2.0.8
remote:        Installing rack 2.0.3
remote:        Fetching rack-protection 2.0.0
remote:        Installing rack-protection 2.0.0
remote:        Fetching sinatra 2.0.0
remote:        Installing sinatra 2.0.0
remote:        Bundle complete! 2 Gemfile dependencies, 6 gems now installed.
remote:        Gems in the groups development and test were not installed.
remote:        Bundled gems are installed into ./vendor/bundle.
remote:        Bundle completed (1.91s)
remote:        Cleaning up the bundler cache.
remote:        Warning: the running version of Bundler (1.15.2) is older than the version that created the lockfile (1.15.3). We suggest you upgrade to the latest version of Bundler by running `gem install bundler`.
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
remote:        https://hangperson2017.herokuapp.com/ deployed to Heroku
remote: 
remote: Verifying deploy... done.
To https://git.heroku.com/hangperson2017.git
 * [new branch]      master -> master
```

And we can see the app running in the specified location:

https://hangperson2017.herokuapp.com/

![hello world on heroku app](https://www.dropbox.com/s/1r2mcq5d1id6wbc/Screenshot%202017-07-31%2017.08.39.png?dl=1)

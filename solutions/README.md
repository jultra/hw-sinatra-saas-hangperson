Hangperson: a scaffolded (!) ESaaS getting-started assignment
=============================================================

In this assignment you'll learn basic cycle of creating SaaS in
a disciplined way, following five basic steps and using a
tool that supports each one: creating, developing (using BDD
and TDD), deploying, versioning, and enhancing SaaS.

This assignment uses the simple Sinatra framework rather than Rails, so
that you can focus on the tools and mechanics.  All the
concepts you learn will readily "map" to Rails later.  Since our app
doesn't have a database and has very few functions, Sinatra is an
easier way to get started.

In particular, in this assignment you will learn how to:

0. Use `bundler` to ensure your project includes the minimum set of
files that will be necessary to **replicate your development environment
in production**, so the app behaves the same way when you deploy it
publicly;

0. Use `git` to manage a **repository** on your development
computer, so you are using proper version-control practices from the start;

0. Use GitHub to make sure your repository is **pushed to the cloud**
both so you have a backup and to allow others to (eventually)
collaborate on your project;

0. Use Heroku to **deploy** your app publicly and frequently to ensure each
incremental change doesn't break anything;

0. Use `cucumber` to implement your app using **behavior-driven design
(BDD)**, allowing you to convert
plain-language descriptions of a new feature's behavior into a real test
that "simulates" a user trying to use that feature;

0. Use `rspec` to create unit-level (detailed) tests for the app to
check the cases not covered by Cucumber scenarios.

We will do this by creating and deploying a simple (but not trivial)
app that implements a Web-based non-graphical
version of the popular game "Hangman", in which the player gets a
limited number of attempts to guess a secret word.  

To make the game fun to play, each time you start a new game the app
will actually retrieve a random English word
from a remote server, so every game will be different.  This feature
will introduce you to two additional important concepts:

* How to take advantage of an external service (the random-word
generator) as a "building blocks" you can use in your own apps--a simple
example of exploiting **Service-Oriented Architecture**

* How to test your app in a predictable and controllable manner by
writing tests that **break the dependency** on the external service at
testing time

# Part 0 (prerequisites)

Before proceeding, you should have basic command-line skills, have a
GitHub account, and know how to create a repository, add
files, and commit changes.   You should also understand the basic
concepts of the architecture of SaaS applications.

## 0.1 Basic Git and GitHub skills: init, add, commit

(You can skip this step if you are already comfortable with Git.)

Read Section A.5 of ESaaS, which introduces the general concepts of
version control through a couple of pages of text and a short screencast
demonstration. 

* Start up the ESaaS courseware VM and try to replicate the steps
  shown in the [screencast](https://vimeo.com/34754947).  When you type
  `git init`, what changes occur in the project directory that you think
  allow Git to track the files?  (**Hint:**  use the command `ls -a`,
  which reveals "hidden" files in a directory, right before and right
  after running `git init`.)  (Answer: a new subdirectory `.git` is
  created to hold Git's tracking information.)

To learn more about Git, open a "Terminal" or "Command line console"
window on your computer in the courseware VM, and type `git-it`.  This
self-paced tutorial has ten "challenges" to teach you Git-related
skills.  You can skip Challenge #1 (Get Git) since we've preinstalled it
in the courseware VM.  (**TBD:** No we haven't yet, but we should.  Requires
installing `node.js`, `npm`, and then `jlord/git-it` from GitHub.)
Complete challenges 2, 3, 4 (Repository, Commit,
Githubbin'); after each one you can run `git-it verify` in the same
terminal window to check if you did it right.

## 0.2 SaaS Architecture

Read Chapter 2 of ESaaS, *The Architecture of SaaS Applications*.  The
terminology we'll use here is explained in that chapter.

# Part 1: Initialize the App With Its Own Repo

> Key concept: How can we make sure our development environment and
> production environment are as similar as possible?

SaaS apps are developed on your computer but *deployed to production* on
a public or internal private server so others can use them.  Therefore a
best practice for developers is to minimize the differences between the
development and production *environments*, to avoid
difficult-to-diagnose problems in which something works one way on your
development computer but a different way (or not at all) when that code
is deployed to production.

We have two mechanisms for keeping the development and production
environments consistent.  The first is *version control*,
which allows us to keep consistent "snapshots" of our code files as we
make changes.  We can then ensure that the "snapshot" that gets deployed
to production corresponds to a particular known-working "snapshot" of
our development environment.  We will use the popular `git` version
control tool to version our code, and the  **GitHub** SaaS service to
back it up and (later) allow others to contribute to our code.

But version control isn't enough by itself, because almost all apps also
rely on *libraries* written by others.  In Ruby, libraries are 
distributed as *Ruby gems* or simply *gems*.
Although the ESaaS courseware VM includes many
preinstalled gems, including the ones you'll need for this assignment,
you still have to ensure that if your app uses any of those  gems, they
are also available in the production environment.

So in the first part of the assignment we'll tackle these two steps:
getting our app under version control immediately, and specifying which
libraries it depends on so that the production environment can be made
to match our development environment.

## 1.1 Create a versioned directory and a Gemfile

We're going to use the **Sinatra** SaaS app framework to create our
simple app.  Sinatra is just a gem (library)---it isn't really part of our
app---but we must specify that we're dependent on it
so that the production environment can match our
development environment.

Happily, Ruby has a wonderful system for managing gem dependencies: a
gem called **Bundler** examines a special file you create called
`Gemfile` containing a list of gems your app depends on, and
verifies that those gems are available on your system.  If any are missing, it
tries to download and install them; if doing so requires other gems to
be installed as will (so-called *dependencies*), it recursively tries to
download and install those.  

* Create a new empty directory to hold your new app, and use `git init`
in that directory to start versioning it with Git.

* In that directory, create a new file called `Gemfile` (the
capitalization is important) with the following contents.  This file
will be a permanent part of your app and will travel with your app
anywhere it goes:

```ruby
source 'https://rubygems.org'
ruby '1.9.3'

gem 'sinatra', '>= 1.4'
```

The first line says that the preferred place to download any necessary
gems is https://rubygems.org, which is where the Ruby community
registers "production ready" gems.

The second line specifies which version of the Ruby language interpreter
is required.  If we omitted this line, Bundler wouldn't try to verify
which version of Ruby is available; there are subtle differences between
the versions, and not all gems work with all versions, so it's best to
specify this.

The last line says we need version 1.4 or later of the `sinatra` gem.
In some cases we don't need to specify which version of a gem we want;
in this case we do specify it because we rely on some features that are
absent from earlier versions of Sinatra.

## 1.2 Run Bundler

Run the command `bundle`, which examines your `Gemfile` to make
sure the correct gems (and, where specified, the correct versions) are
available, and tries to install them otherwise.  This will create a new
file `Gemfile.lock`.  

* What's the difference between the purpose and contents of `Gemfile`
and `Gemfile.lock`?  Which file is needed to completely reproduce the
development environment's gems in the production environment?
   (Answer: `Gemfile` specifies the gems you need and
in some cases the constraints on which version(s) are acceptable.
`Gemfile.lock` records the *actual* versions found, not only of the gems
you specified explicitly but also any other gems on which they depend.)

## 1.3 Configure the app server

As Chapter 2 of ESaaS explains, SaaS apps:

* ...require an application server, which mediates "connects" the app to the rest
of the Web server infrastructure.  We will use `rack`, a Ruby-based application server.

* ...are "fronted" by a presentation tier, such as a Web server, which
receives requests and directs them to the appropriate application
server, which in turn mediates between the presentation tier and your
app's code.  We'll use WEBrick, a very
simple Ruby-based web server.

* ...are often but not always built using a *framework*, which
simplifies some common aspects of communicating with the application
server and/or building the app itself, such as dealing with cookies.
We'll use Sinatra, a
lightweight framework for creating SaaS apps in Ruby.

Since HTTP is a request-reply protocol, a SaaS app is essentially a
collection of *handlers* for different requests the user might make.
ESaaS Chapter 2 introduced the idea of HTTP methods (`GET`, `POST`, and
so on) and how they can name RESTful actions.  Our Hangperson game will
have various RESTful actions---start new game, guess a letter, and so
on---but for now, just to get things going, we will create the simplest
possible handler to handle requests to the "root URL" of our app.

Create a file in your project called `app.rb` containing the following:

```ruby
require 'sinatra'

get '/' do
  "Hello World"
end
```

The `get` method is provided by the Sinatra library, which we load in
line 1.

* What's our guarantee that this library is available?
  (Answer: we specified it in the `Gemfile` *and* successfully ran
  `bundle` to either verify its presence or install it.)

Sinatra lets you write functions that match an incoming HTTP
request's method and URL.  In this case, if the HTTP method is `GET` and
the URL is `/` (the root URL), the string `Hello World` will be returned
to the presentation tier as the result of the request.

To "run" our app, we have to start the
application server and presentation tier (web) server.  The `rack`
application server is controlled by a file `config.ru`, which you must
now create, containing the following:

```ruby
require './app'
run Sinatra::Application
```

The first line tells Rack that our app lives in the file `app.rb`, which
you created above 
to hold your app's code.  Observe that `require 'sinatra'` works because there are standard places on each system where
gems are usually stored, and `require` knows to look there by default;
whereas here we have to explicitly provide the location of the file--the Unix
notation `./` refers to "the current directory"--to load a file that
*isn't* a gem stored in the usual place.

## 1.4 Run the app

We're now ready to test-drive our simple app with this command line:

```bash
rackup
```

This command starts the Rack server and the WEBrick webserver.  Rack
will look for `config.ru` and attempt to start our app based on the
information there.

* ESaaS Chapter 2 explained the concept of TCP port numbers and
hostnames.  From the messages printed out by `rackup` as Rack is
starting, what URL should you type into your browser to communicate with
our running app?  (answer: `http://localhost:9292`)

Point your Web browser at the running app and verify that you can get
"Hello World".

* What happens if you try to visit a non-root URL such as
`http://localhost:9292/hello`?

## 1.5 Modify the app

* Modify `app.rb` so that visiting `http://localhost:9292/hello` also
returns "Hello World".  Save your changes to `app.rb` and try visiting
that URL again.  *Verify that it doesn't work!*  (**TBD:** I'd like a
better way to scaffold this piece...)

You can do this several ways, but an easy one is to add another method
to `app.rb`:

```ruby
get '/hello' do
  "Hello World"
end
```

* Go back to the shell window where you ran `rackup` and press Ctrl-C to
stop Rack.  Then type `rackup` again, and once it is running, go back to
your web browser and try the URL again.  This time it should work.

What this shows you is that if you modify your app while it's running,
you have to restart Rack in order for it to "see" those changes.  Since
restarting it manually is tedious, we'll use the `rerun` gem, which
restarts Rack (or any other process) automatically when it sees changes
to files in the app's directory.

You're probably already thinking: "Aha! If our app depends on this
additional gem, we should add it to the `Gemfile` and run `bundle` to
make sure it's really present."  Good thinking.  But it may also occur
to you that this particular gem wouldn't be necessary in a production
environment: we only need it as a tool while developing.  Fortunately,
there's a way to tell Bundler that some gems are only necessary in
certain environments.  Add the following to the Gemfile (it doesn't
matter where):

```ruby
group :development do
  gem 'rerun'
end
```

Any gem specifications inside the `group :development` block will only
be examined if `bundle` is run in the development environment.  

> The
> choices for environments are `:development`, `:test`, and
> `:production` (and in fact you can define new environments yourself).
> Gem specifications outside of any `group` block are assumed to apply
> in all environments.

* Say `rerun rackup` in the terminal window to start your app and verify
the app is running.

* Modify `app.rb` to also respond to `http://localhost:9292/new` with
the string "New world".  Verify that as soon as you save the file,
`rackup` is automatically restarted for you (you may have to wait a
couple of seconds for the restart to complete).

## Summary of part 1

* You started a new application project by creating a `Gemfile`
specifying which gems you need and running `bundle` to verify that
they're available and create the `Gemfile.lock` file that records the
versions of gems actually in use.

* You created a Sinatra app in the file `app.rb`, pointed Rack at
this file in `config.ru`, and used `rackup` to start the appserver and
the WEBrick web server.

* You learned that changing the app's code doesn't automatically cause
Rack to reload the app.  To save the work of restarting the app manually
every time you make a change, you used the `rerun` gem, adding it to the
Gemfile in a way that specifies you won't need it in production, only
during development.


# Part 2: Get your project under version control

## 2.1 Start Versioning

Before going any further, `git add` the files in your project so far:
`Gemfile`, `Gemfile.lock`, `app.rb`, and `config.ru`,
and then commit.  (Your basic Git skills from Part 0 should cover this.) 

## Summary of part 2

0. Setting up your app for version control by running `git init` in its
directory

0.  Doing your first commit to add the files that make up your app so
far

0. 



# Part 3: Deploy to Heroku

# Part 4: Write a Scenario for a New Feature

# Part 5: Fill in the New Feature

# Part 6: Push and Deploy the New Feature


# Conclusion

This assignment has served as a microcosm or miniature tour of the
entire course: during the rest of the course we will investigate each of
these in much more detail, and we will also add new techniques---

* *Test-driven development (TDD)* will let you write much more
detailed tests for your code and determine its **coverage**, that is,
how thoroughly your tests exercise your code.  We will use **RSpec** to
do test-first development, in which we write tests before we write the
code, watch the test fail ("red"), quickly write just enough code to make the
test pass ("green"), clean up (refactor) the code, and go on to the next test.  We
will use the `autotest` tool to help us get into a rhythm of red--green--refactor.

* *Code metrics* will give us insight into the quality of our code: is
it concise?  Is it factored in a way that minimizes the cost of making
changes and enhancements?  Does a particular class try to do too much
(or too little)?  We will use **CodeClimate** (among other tools) to
help us understand the answers.  We can check both quantitative metrics,
such as test coverage and complexity of a single method, and qualitative
ones, such as adherence to the *SOLID Principles* of object-oriented
design.

* *Refactoring* means modifying the structure of your code to improve
its quality (maintainability, readability, modifiability) while
preserving its behavior.  We will learn to identify *antipatterns* --
warning signs of deteriorating quality in your code -- and opportunities
to fix them, sometimes by applying *design patterns* that have emerged
as "templates" capturing an effective solution to a class of similar
problems. 

# Part 7: optional challenge assignment

## 7.1

Verify that a file exists on the courseware VM called
`/usr/share/dict/words`.  What's in it?

> This file has been part of Unix since almost 
> [the beginning of time](http://en.wikipedia.org/wiki/Unix_time), 
> although it 
> [has moved around](http://objectroot.org/articles/brief-history-of-hier/) 
> since then.  It has been used by programs ranging from spelling
> checkers to password guessers.

## 7.2

Why do you think we used a remote SOA endpoint to generate random words
for Hangperson rather than `/usr/share/dict/words`?  (Hint: It's not
simply to give you an initial taste of using SOA.)


## 7.3

Using Sinatra, create and deploy locally (on your computer) a *SOA
endpoint* that mimics the behavior of the Random Word Generator service
we used in this assignment.  A simple implementation would respond to the
RESTful request `GET /` with a random word drawn randomly from
`/usr/share/dict/words`. 

## 7.4 (more sophisticated, optional) 

A more sophisticated
implementation would respond to *any* `GET` request with a random word,
and reject or ignore non-`GET`s (since it is arguably non-RESTful to use
a `POST` or `PUT` or `DELETE` on a resource that won't be changed by the
request).

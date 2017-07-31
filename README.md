Hangperson CI 
=============

[![Build Status](https://magnum.travis-ci.com/saasbook/hw-sinatra-saas-hangperson-ci.svg?token=CPXPCn5Dy1cwCKsavtqL&branch=master)](https://magnum.travis-ci.com/saasbook/hw-sinatra-saas-hangperson-ci)

Please find instructions for the homework itself at: https://github.com/saasbook/hw-sinatra-saas-hangperson-ci/blob/master/README.md

This is a separate (private) repo that contains the solutions and walkthrough, as well as tests of various aspects of the assignment.

### Current Test running

Testing doesn't currently work

### Legacy Test Running

The following approach is what used to work for an old version of the grader that allowed us to grade assignsments from the command line.  However that functionality was removed following the refactoring to use the XQueue gem ...

To bundle install everything on OSX you might first need:

```
$ brew install libmagic
```

In order to run the tests first run the following to install the latest production version of the grader:

```sh
$ bundle exec cucumber install/
```

Note the above command might take a long time to install since it will be installing all the gems for the grader itself.

Assuming that installs the grader successfully you can then run the cucumber tests of the assignment itself against the production grader like so:

```sh
$ bundle exec cucumber
```


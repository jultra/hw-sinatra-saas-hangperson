#!/bin/bash

#initializes RVM
source /etc/profile.d/rvm.sh 
#runs autograder, prints results and sends grade to Codio
python3 .guides/secure/gradescope.py sinatra-url.txt
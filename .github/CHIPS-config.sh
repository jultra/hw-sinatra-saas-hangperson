#!/usr/bin/env bash
chips_number="3.7"
chips_name="hw-sinatra-saas-hangperson"
ci_repo_link="https://github.com/saasbook/hw-sinatra-saas-hangperson-ci"
not_ci_repo_ssh="git@github.com:saasbook/hw-sinatra-saas-hangperson.git"
commit_message="Automated Commit. CHIPS ${chips_number}: ${chips_name} - This repository is created by automation from \
github workflows, found at ${ci_repo_link}."
final_folder="^./root\(/.*\)?"


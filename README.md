# README #

### What is this? ###

This repository is used for automated smoke test and functional test of web application.

* Based on: selenium-ruby-cucumber - web application BDD test

### How do I get set up? ###

`gem install bundler`

`bundle install`

### How do I execute test? ###

To run all test cases (feature files) on headless Firefox mode

`cucumber -p headless`

To run all test cases (feature files) on Browserstack platform
(Use your browserstack account set up in env.yml)

`cucumber -p bs`

To run all test cases (feature files) on real Firefox browser

`cucumber -p ff`

### More options to run test cases ###

`cucumber -p wip`

only run @wip on default env against default browser

`cucumber features/feature_name.feature`

run feature_name.feature on default env against default browser but not features with @skip

`cucumber features/feature_name.feature -p stage -p ff`

run feature_name.feature on stage env against ff browser but not features with @skip

# README #

### What is this? ###

This repository is used for automated smoke test and functional test of web application.

* Based on: selenium-ruby-cucumber - web application BDD test

### How do I get set up? ###

* Create virtual env for installing all dependencies

Install rvm

`sudo apt-get install rvm`

Install ruby

`rvm install ruby --default`

Check ruby version

`ruby --version`

Create a gemset (Where virtualenv has “environments”, RVM has “gemsets”)
```
rvm use 2.3.1
rvm gemset create bfa_ui_test
rvm gemset use bfa_ui_test
```

Install dependencies
```
gem install bundler
bundle install
```

Only run these commands to clean up your gemset (virtual environment for ruby)
```
rvm gemset empty bfa_ui_test
rvm gemset delete bfa_ui_test
```

### How do I execute test? ###

* To run all test cases (feature files) on headless Firefox mode

`cucumber -p headless`

* To run all test cases (feature files) on Browserstack platform

`cucumber -p bs`

* To run all test cases (feature files) on real Firefox browser

`cucumber -p ff`

### More options to run test cases ###

only run @wip on default env against default browser

`cucumber -p wip`

run feature_name.feature on default env against default browser but not features with @skip

`cucumber features/feature_name.feature`

run feature_name.feature on stage env against ff browser but not features with @skip

`cucumber features/feature_name.feature -p stage -p ff`

run multiple envs
```
cucumber -p bs_ff
cucumber -p bs_ie
cucumber -p bs_chrome
cucumber -p bs_edge
cucumber -p bs_ipad
cucumber -p bs_iphone5s
cucumber -p bs_iphone6

```

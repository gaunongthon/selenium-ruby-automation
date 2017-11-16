# README #

### What is this? ###

* Framework: selenium-ruby-cucumber - web application BDD test
* Platform: browserstack

### How do I get set up? ###

`gem install bundler`

`bundle install`

### How do I execute test? ###

`cucumber -p bs`

run all features on browser stack platform

### More options to run test cases ###

`cucumber -p wip`

only run @wip on default env against default browser

`cucumber -p chrome`

run all features on default env against chrome browser but not features with @skip

`cucumber features/feature_name.feature`

run feature_name.feature on default env against default browser but not features with @skip

`cucumber features/feature_name.feature -p stage -p ff`

run feature_name.feature on stage env against ff browser but not features with @skip

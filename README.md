# README #

### What is this? ###

This repository is used for automated smoke test and functional test of web application.

* Based on: selenium-ruby-cucumber - web application BDD test

### How do I get set up? ###

Create virtual env for installing all dependencies

Install rvm
```
sudo apt-add-repository -y ppa:rael-gc/rvm
sudo apt-get update
sudo apt-get install rvm
```

Install ruby

`rvm install ruby --default`

Check ruby version

`ruby --version`

Create a gemset (Where virtualenv has “environments”, RVM has “gemsets”)
```
rvm use 2.3.1
rvm gemset create selenium_ui_test
rvm gemset use selenium_ui_test
```

Install dependencies
```
gem install bundler
bundle install
```

Only run these commands to clean up your gemset (virtual environment for ruby)
```
rvm gemset empty selenium_ui_test
rvm gemset delete selenium_ui_test
```

### How do I execute test locally? ###

Dowload web drivers on your machine.
* Firefox: https://github.com/mozilla/geckodriver/releases/
* Chrome: http://chromedriver.storage.googleapis.com/index.html

Install chromedriver if not available 
```
mkdir ~/downloads
cd ~/downloads
wget https://chromedriver.storage.googleapis.com/2.42/chromedriver_linux64.zip
sudo apt install unzip
unzip chromedriver_linux64.zip
```

Update PATH
```
vim  ~/.bashrc
```

Add this line at the end:
```
export PATH="/home/michael/download/webdrivers:$PATH"
```

To make changes in `~/.bashrc` to take effect immediately, do:
```
source ~/.bashrc
```

Confirm `chromedriver` set-up by running:
```
which chromedriver
chromedriver -version
```

Install google-chrome if not available 
```
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i ./google-chrome*.deb
sudo apt-get install -f
```

Confirm `google-chrome` set-up by running:
```
google-chrome -version
```

* Notes: See Chromedriver version vs Google-chrome version compatibility at http://chromedriver.chromium.org/downloads

To run all test cases (feature files) on real Firefox browser
```
cucumber -p ff
```

To run all test cases (feature files) on real Chrome browser
```
cucumber -p chrome
```

### How do I execute test locally in headless mode? ###

To run all test cases (feature files) on headless Firefox mode
```
sudo apt-get install xvfb
cucumber -p headless
```

### How do I execute test remotely on browserstack? ###

To run all test cases on Browserstack platform
```
cucumber -p bs_ff //Latest Firefox on Windows 10
cucumber -p bs_ie  //Latest IE on Windows 10
cucumber -p bs_chrome //Latest Chrome on Windows 10
cucumber -p bs_edge //Latest Edge on Windows 10
cucumber -p bs_ipad //Latest Safari on iPad 5th iOS 11.x
cucumber -p bs_iphone8 //Latest Safari on iPhone 8 iOS 11.x
cucumber -p bs_iphone7plus //Latest Safari on iPhone 7plus iOS 10.x
cucumber -p bs_s8plus //Native browser on Samsung Galaxy S8 plus Android 7.x
cucumber -p bs_s6 //Native browser on Samsung Galaxy S6 Android 5.x
```

### More options to run test cases ###

only run @wip on default env against default browser
```
cucumber -p wip -p ff
```

run feature_name.feature on default env against default browser but not features with @skip
```
cucumber -p headless features/feature_name.feature
```

run feature_name.feature on default env against ff browser but not features with @skip
```
cucumber features/feature_name.feature -p ff
```

### How do I view test report? ###
```
google-chrome reports/results.html
```

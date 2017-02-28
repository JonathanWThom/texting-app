# Weather Texter
## Jonathan Thom

This is a Ruby on Rails app in process.

### Current Features
1. Will allow my Twilio account to text validated numbers.
2. You can add contacts and text them (but again, numbers must be validated).
3. Validated numbers can text the app "weather <some zip code>" to receive a forecast. They can add "long" to the text to receive an extended forecast.

### Future Features
1. Perhaps adding a paid tier to Twilio, so I can validate other numbers through the app.
2. Deploy to Heroku and use that enpoint, rather than ngrok locally, to receive text messages.
3. Deploy to Heroku and use the Heroku scheduler to send weather updates every day.

_I made this app on the day that S3 went down, so currently Heroku is MIA_

### Tech

* Ruby on Rails
* Twilio API
* Open Weather API
* Many cool gems
* Testing: Rspec, Capybara, PhantomJS, Simplecov, VCR. 

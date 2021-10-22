package:
	bundle exec rake package

tests:
	bundle exec rake test

gem.push:
	ls pkg/*.gem | xargs gem push

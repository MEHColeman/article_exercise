# Olio Articles

# Installation
~~~sh
$ bundle install
$ bundle exec rails db:create
$ bundle exec rails db:migrate
~~~

# Development and Testing

In addition to the installation steps above, please note that the feature test
uses capybara & selenium-firefox. To run selenium on a different browser, please
see https://github.com/teamcapybara/capybara#selenium

You can run `bundle exec guard` to automatically run tests as you develop or
`rspec` to run manually.
Run `make all` to run a selection of code metrics software like simplecov
and rubycritic.
Rubycritic will open a browser window automatically. To view the simplecov
results, you can use `open coverage/index.html`

# Usage
~~~sh
bundle exec rails server           # run the server
open http://localhost:3000/        # open the site in your browser.
~~~

The site should display a list of articles. Click the empty hearts to _like_
articles.

# Development Notes

Well, this is an interesting problem. Instead of the usual ActiveRecord database
model, we need to retrieve data from a JSON api every time the page is loaded.

This has a number of things to think about.

1. Normally, you'd want to consider making external requests like this
as a background job. Requests over the network are often slower and more
unreliable, and your http process will be waiting while the API request is made
and processed.

I think in this case, we should assume that this is more like a mock JSON
API and is fast and stable enough - more like a microservice we use than an
'external' data source.

As such we should be able to use ActiveResource to handle the data models. You
could just parse the JSON file, but again, this `article` resource feels like a
mock of a service that could ultimately make use of other RESTful actions.

2. We also want to add a 'like' button. This _is_ a typical ActiveRecord type of
task.

3. The audience is specifically a rails novice running a local environment. This
make me lean towards a very simple database implementation like sqlite, rather
than anything that needs to be installed and/or configured. That's fine, that's
the default.

4. My development approach is typically:
    1. Create a feature branch.
    2. Write a failing feature test. Once this test passes, the feature is complete.
    3. Top-down TDD from the feature test down the stack. Use test doubles if appropriate to isolate unit tests.
    4. Refactor and tidy up code if necessary.
    5. Consider logging and unhappy-path tests and error handling.

5. I am consciously allowing the list of articles to look awful for now. I don't
think the focus of the task is to have a good looking site, and you can easily
spend hours tweaking the look. I've gone with a simple table that demonstrates
that data is coming back from the JSON API. I might revisit the GUI later, but
the task is supposed to be short.

6. This is a bit of an odd one.... ActiveResource and AcitveModel don't interact
well together, so we have to finesse some relation methods a bit... Ideally,
the 'like' feature should be integrated of the api for the Article service.
Here it is stored independently. I really don't want an N+1 query going on when
looking the Like relation. A first solution is to get back a list of off the
liked Article IDs, and checking against it. Rails will automatically cache this
database query when a request is made (except in development or test mode).

7. The integration test assumes some values for results returned from the JSON
file. However, the task specifically says that the file data may change. This
would make the tests break. You could use a gem like VCR to mitigate this by
recording and replaying network requests.

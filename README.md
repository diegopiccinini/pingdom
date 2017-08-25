# Pingdom
This a free software library to get data from api.pingdom.com, is a Diego Piccinini and BookingBug contribution to the free software and open source community.

It is not oficial. It has 2 ways to setup the client

- Using a dotenv file `.env` file

```bash
#.env
PINGDOM_USERNAME=your pingodom email here
PINGDOM_PASSWORD=your pingdom password here
PINGDOM_KEY=your pingdom key here
#PINGDOM_VERSION= optional you cuould change the api/{version} here

```

- Or udate the client like:

```ruby

  Pingdom::Check.update_client username: 'your pingdom@email here', password: 'your pingdom password here' , key: 'your pingdom key here'

```

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pingdom'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install pingdom

## Usage

### Checks

To get all checks

```ruby
checks = Pingdom::Check.all
checks.each do |check|
  puts check.name
  puts check.id
 end
```

To get one check using find, you need the id

```ruby
check = Pingom::Check.find 85975
# return a check or raise an error if the chech is not found
```

### Summary Outages

Get the Summary Outage by check id:

```ruby

summary_outage = Pingdom::SummaryOutage.find check_id

# With params from, to and order are not mandatory params

summary_outage = Pingdom::SummaryOutage.find check_id , from: 2.days.ago, to: 1.days.ago, order: 'ask'

# get up and down times
summary_outage.ups
=> 120

summary_outage.downs
=> 4

# get up and down times with min_interval to filter (in seconds)
summary_outage.ups min_interval: 300 # more than 5 minuts
=> 10
summary_outage.downs min_interval: 180 # more than 3 minutes
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pingdom. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Pingdom project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/pingdom/blob/master/CODE_OF_CONDUCT.md).

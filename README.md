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
check = Pingdom::Check.find 85975
# return a check or raise an error if the chech is not found

# with tags
check = Pingdom::Check.find 85975, include_tags: true
```

### Summary Average

Get the Sumary Average by check id:

```ruby
average = Pingdom::SummaryAverage.find check_id

average.from # is a Time
=> 1970-01-01 01:00:00 +0100

average.to # is a Time
=> 2017-09-05 15:43:53 +0100

average.avgresponse # is a Integer
=> 381

# with parameters

average = Pingdom::SummaryAverage.find check_id, from: 10.days.ago , to: 1.day.ago, probes: '44,33'

# includeuptime

average = Pingdom::SummaryAverage.find check_id, includeuptime: true
# get status data
average.status.totalup
average.status.totaldown
average.status.totalunknown

# bycountry

average = Pingdom::SummaryAverage.find check_id, bycountry: true

average.avgresponse # is an Array of Struct::AvgResponse
r = average.avgresponse.firt
r.country
=> 'UK'

r.avgresponse
=> 92

r.from # and r.to are Times
=> 1970-01-01 01:00:00 +0100

# byprobe

average = Pingdom::SummaryAverage.find check_id, byprobe: true
a=average.probe_responses # is array of Struct::ProbeResponse

# Get data of each probe response
r=a.first
r.id # the id of the probe
r.avgresponse
r.n # integer
r.from
r.to

average.from # Time of request filter
=> 1970-01-01 01:00:00 +0100
average.to # Time of request filter
=> 2017-09-05 15:43:53 +0100

```

### Summary Outages

Get the Summary Outage by check id:

```ruby

summary_outage = Pingdom::SummaryOutage.find check_id

# With params from, to and order are not mandatory params

summary_outage = Pingdom::SummaryOutage.find check_id , from: 2.days.ago, to: 1.days.ago, order: 'desc'

# get up and down times
summary_outage.ups
=> 120

summary_outage.downs
=> 4

# get up and down times with min_interval to filter (in seconds)
summary_outage.ups min_interval: 300 # more than 5 minuts
=> 10

summary_outage.downs min_interval: 180 # more than 3 minutes
=> 2

```

### Summary Performance

Get the Summary Performance by check id:

```ruby

summary_performance= Pingodm::SummaryPerformance find check_id

# available params from: Time , to: Time, resolution: 'hour' | 'day'| 'week' , includeuptime: true | false

# When you find by a hour resolution you can get hours
summary_performance.hours.each do |h|
  puts h.starttime # Time
  puts h.avgresponse # Integer
  puts h.uptime # Integer
  puts h.downtime # Integer
  puts h.unmonitored # Integer
end

# the same behavior with 'week' and 'day' resolutions, you can get the data of each one use the same methods.

summary_performance.weeks.is_a
=> Array # of Struct::Week

summary_performance.day.is_a
=> Array # of Struct::Day

```

### ServerTime

Easy way to get the servertime

```ruby
Pingdom::ServerTime.time
=> 2017-09-05 17:47:56 +0100 #Time object of the servertime
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

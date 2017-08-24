# Pingdom
This library has 2 ways to setup the client

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


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/pingdom. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

## Code of Conduct

Everyone interacting in the Pingdom project’s codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/[USERNAME]/pingdom/blob/master/CODE_OF_CONDUCT.md).

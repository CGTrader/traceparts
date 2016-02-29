# Traceparts

Minimal Traceparts [traceparts.com](http://www.traceparts.com/developers) API wrapper.

Currently it lacks tests and [http error codes](http://www.traceparts.com/developers/http-error-codes/) handling.

It can be used for:

  * [List of catalogs](http://www.traceparts.com/developers/list-catalogs-api/) endpoint
  * [List of categories](http://www.traceparts.com/developers/categories-list-api/) endpoint
  * [List of products](http://www.traceparts.com/developers/products-list-api/) endpoint - Default size is 30000 (could be improved)
  * [PartNumber data](http://www.traceparts.com/developers/partnumber-data-api/) endpoint
  * [Availability of CAD data](http://www.traceparts.com/developers/cad-format-availability-api/) endpoint
  * [Download CAD file](http://www.traceparts.com/developers/download-cad-file-api/) endpoint - extract archive link
  * [User existence](http://www.traceparts.com/developers/user-account-api/) endpoint
  * [User creation](http://www.traceparts.com/developers/user-account-creation-api/) endpoint

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'traceparts'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install traceparts

## Usage

### Setup client

```ruby
ACCESS_TOKEN = 'YOUR_TRACEPARTS_ACCESS_TOKEN'

client = Traceparts::Client.new(ACCESS_TOKEN)
```

### Some test data

```ruby
id = 'PNEUMADYNE'
part_number = 'A11-31-14'
email = 'your@email.com'
format_id = 11
```

### Catalog related functionality

```ruby
catalogs = client.catalogs
catalog = catalogs.first

categories = catalog.categories
category = categories.first

category_products = category.products
category_product = category_products.first

catalog_products = catalog.products
catalog_product = catalog_products.first
```

### User related functionality

```ruby
user = client.user(user_email)

# Option 1 (suggested)
user.exists? # true or false
user.register(company, country, first_name, last_name, phone) # true or false

user.email

# Option 2
client.user_exists?(user_email) # true or false
client.register_user(user_email, company, country, first_name, last_name, phone) # true or false
```

### PartNumber data related functionality

#### Option 1 (suggested)

```ruby
part = client.part(id, part_number, email)

details = part.details
formats = part.available_formats
download_link = part.download_archive_link(format_id)
```

#### Option 2

```ruby
details = client.part_details(id, part_number, email)
formats = client.available_formats(id, part_number, email)
download_link = client.download_archive_link(id, part_number, format_id, email)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment. Or if you want to be fancy and use `pry` instead of `irb` you can also run `rake console` that I have specifically made for easier testing.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/CGTrader/traceparts.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).


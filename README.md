# PgMonitor

PgMonitor is a Ruby gem that provides insights into PostgreSQL database.
It would integrate seamlessly with a Rails application in the future, and would expose statistics via a mounted route.

## Features

- View index usage statistics (last used, scan count, etc.)
- Identify slow queries using `pg_stat_statements`
- [TBD] Works with the existing Rails database configuration
- [TBD] Provides a simple HTML interface for monitoring

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'pg_monitor'
```

And then execute:

```sh
bundle install
```

Or install it manually:

```sh
gem install pg_monitor
```

## Configuration

### Enable `pg_stat_statements`

Ensure that `pg_stat_statements` is enabled in your **PostgreSQL configuration**.

Modify `postgresql.conf`:

```conf
shared_preload_libraries = 'pg_stat_statements'
pg_stat_statements.track = all
track_activity_query_size = 2048
```

Restart PostgreSQL after making the changes:

```sh
sudo systemctl restart postgresql
```

## Usage

Mount the engine in `config/routes.rb`:

```ruby
mount PgMonitor::Engine, at: '/pg_monitor'
```

Then, navigate to:

```
http://localhost:3000/pg_monitor
```

### Programmatic Access

#### **Index Usage**
```ruby
PgMonitor::IndexUsage.fetch
```

#### **Slow Queries**
```ruby
PgMonitor::SlowQueries.fetch(limit: 10)
```

## Running Tests

### **1. Start PostgreSQL in Docker**

Ensure you have Docker installed, then start the database:

```sh
docker-compose up -d postgres
```

### **2. Run Tests**

```sh
docker-compose run --rm test-runner
```

Or directly using RSpec:

```sh
bundle exec rspec
```

## Contributing

1. Fork the repo
2. Create a feature branch (`git checkout -b my-feature`)
3. Commit your changes (`git commit -m 'Add new feature'`)
4. Push to the branch (`git push origin my-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License.

## Author
Created by [Hassan Murtaza](https://github.com/hmurtaza7).

# Time::Zone

A very simple time-zone library which works by manipulating the `TZ` environment variable.

[![Build Status](https://secure.travis-ci.org/ioquatix/time-zone.svg)](http://travis-ci.org/ioquatix/time-zone)
[![Code Climate](https://codeclimate.com/github/ioquatix/time-zone.svg)](https://codeclimate.com/github/ioquatix/time-zone)
[![Coverage Status](https://coveralls.io/repos/ioquatix/time-zone/badge.svg)](https://coveralls.io/r/ioquatix/time-zone)

## Motivation

`tzinfo` has an antiquated view of `Time`. It returns local time values with a UTC time zone which is pretty much wrong.

[![A brief history of Time.new](https://img.youtube.com/vi/UjdtH5gO_DQ/0.jpg)](https://www.youtube.com/watch?v=UjdtH5gO_DQ)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'time-zone'
```

And then execute:

	$ bundle

Or install it yourself as:

	$ gem install time-zone

## Usage

There are two basic use cases, getting the current time, and converting times.

### Current Time

```ruby
Time::Zone.now("Pacific/Auckland")
=> 2018-05-25 14:09:40 +1200
```

### Convert Time

```ruby
Time::Zone.convert(Time.now.utc, "Pacific/Auckland")
=> 2018-05-25 14:14:22 +1200
```

### Multiple Operations

```ruby
Time::Zone.with("US/Pacific") do
	# Be aware that in some cases Time values are lazy initialized, so you need to use #localtime to force them to evaluate and use the current `TZ`.
	time = Time.new.localtime
	puts time.inspect
	# => 2018-05-24 20:32:29 -0700
end
```

### Caveats

This implementation manipulates the per-process `TZ` environment variable. This means that if you don't put locking around all your usage of `localtime`, you may end up with strange results (i.e. in a timezone other than the system specified `TZ`). In the future, this requirement may go away.

This library is unlikely to work on Windows because it doesn't correctly handle changes to `TZ`.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Released under the MIT license.

Copyright, 2012, 2014, by [Samuel G. D. Williams](http://www.codeotaku.com/samuel-williams).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

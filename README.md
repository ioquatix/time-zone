# Time::Zone

A very simple time-zone library which works by manipulating the `TZ` environment variable.

[![Build Status](https://secure.travis-ci.org/kurocha/time-zone.svg)](http://travis-ci.org/kurocha/time-zone)
[![Code Climate](https://codeclimate.com/github/kurocha/time-zone.svg)](https://codeclimate.com/github/kurocha/time-zone)
[![Coverage Status](https://coveralls.io/repos/kurocha/time-zone/badge.svg)](https://coveralls.io/r/kurocha/time-zone)

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

There are two basic use cases:

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

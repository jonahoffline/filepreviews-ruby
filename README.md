# FilePreviews.io (Ruby client)
[![Build Status](https://travis-ci.org/jonahoffline/filepreviews-ruby.svg)](https://travis-ci.org/jonahoffline/filepreviews-ruby)
[![Gem Version](https://badge.fury.io/rb/filepreviews.svg)](http://badge.fury.io/rb/filepreviews)
[![Dependency Status](https://gemnasium.com/jonahoffline/filepreviews-ruby.svg)](https://gemnasium.com/jonahoffline/filepreviews-ruby)
[![Code Climate](https://codeclimate.com/github/jonahoffline/filepreviews-ruby.png)](https://codeclimate.com/github/jonahoffline/filepreviews-ruby)
[![Inline docs](http://inch-pages.github.io/github/jonahoffline/filepreviews-ruby.png)](http://inch-pages.github.io/github/jonahoffline/filepreviews-ruby)
[![Gitter chat](https://badges.gitter.im/jonahoffline/filepreviews-ruby.png)](https://gitter.im/jonahoffline/filepreviews-ruby)

This is the ruby client library for the **Demo API** of [FilePreviews.io](http://filepreviews.io) service. A lot more to come very soon.

[Sign up to beta](http://eepurl.com/To0U1)

## Installation

Add this line to your application's Gemfile:

    gem 'filepreviews'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install filepreviews

## Usage

### Basic Example Code
```ruby

require 'filepreviews'

url = 'http://pixelhipsters.com/images/pixelhipster_cat.png'
result = Filepreviews.generate(url)

result.preview_url
result.metadata_url
result.metadata
```

#### Web Page Screencaptures
```ruby

require 'filepreviews'

url = 'http://pixelhipsters.com'
result = Filepreviews.generate(url)

result.preview_url
result.metadata_url
result.metadata
```


#### Options
You can optinally send an options object.

```ruby

require 'filepreviews'

options = {
  size: {
    width: 100,
    height: 999
  },
  # supported: 'exif', 'ocr', 'psd' or 'all' which means everything
  metadata: ['exif', 'ocr', 'psd']
}

result = FilePreviews.generate(url, options)
result.preview_url
result.metadata_url
result.metadata
```

### Command-Line Application
Options:

  * -m, --metadata - load metadata response
  * -v, --version  - display the version
  * -h, --help     - print help

## Author
  * [Jonah Ruiz](http://www.pixelhipsters.com)

## Discussion
If you have any questions, ideas or jokes:

[![Gitter chat](https://badges.gitter.im/jonahoffline/filepreviews-ruby.png)](https://gitter.im/jonahoffline/filepreviews-ruby)

## Contributing

Is it worth it? let me fork it

I put my thing down, flip it and debug it

Ti gubed dna ti pilf nwod gniht ym tup I

Ti gubed dna ti pilf nwod gniht ym tup I

# FilePreviews.io (Ruby client)
[![Gem Version](http://img.shields.io/gem/v/filepreviews.svg?style=flat)](http://badge.fury.io/rb/filepreviews)
[![Build Status](http://img.shields.io/travis/jonahoffline/filepreviews-ruby.svg?style=flat)](https://travis-ci.org/jonahoffline/filepreviews-ruby)
[![Dependency Status](http://img.shields.io/gemnasium/jonahoffline/filepreviews-ruby.svg?style=flat)](https://gemnasium.com/jonahoffline/filepreviews-ruby)
[![Code Climate](http://img.shields.io/codeclimate/github/jonahoffline/filepreviews-ruby.svg?style=flat)](https://codeclimate.com/github/jonahoffline/filepreviews-ruby)
[![Gitter chat](https://img.shields.io/badge/gitter-filepreviews--ruby-blue.svg?style=flat)](https://gitter.im/jonahoffline/filepreviews-ruby)
[![Inline docs](http://inch-pages.github.io/github/jonahoffline/filepreviews-ruby.png)](http://inch-pages.github.io/github/jonahoffline/filepreviews-ruby)

This is the ruby client library for the **Demo API** of [FilePreviews.io](http://filepreviews.io) service. A lot more to come very soon.

## Installation

Add this line to your application's Gemfile:

    gem 'filepreviews'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install filepreviews

## Usage
You can currently use the Filepreviews.io API through this gem without registering your application. However, this may change anytime in the future. 

For additional features and greater customization, register your application for an API key at [Filepreviews.io](http://bit.ly/filepreviews-signup) 

### Configuration
To configure the gem to use your newly-registered `api_key`, you can use one of the two configuration styles:

Block style:
```ruby
require 'filepreviews'

Filepreviews.configure do |config|
  config.api_key = 'YOUR_API_KEY'
end
```

Simpler style: 
```ruby
require 'filepreviews'

Filepreviews.api_key = 'YOUR_API_KEY'
```

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
url = 'http://pixelhipsters.com'
result = Filepreviews.generate(url)

result.preview_url
result.metadata_url
result.metadata
```


#### Options
You can optionally send an options object (per request).

```ruby
conf = {
  options: {
    size: {
      width: 100,
      height: 999
    },
    # supported: 'exif', 'ocr', 'psd', 'checksum', 'multimedia',
    # and 'all' which means everything
    metadata: ['exif', 'ocr', 'psd'],

    # supported: 'jpg', 'jpeg', 'png'
    format: 'jpg'
  }
}

result = FilePreviews.generate(url, conf)
result.preview_url
result.metadata_url
result.metadata
```

### Command-Line Application
Options:

  * -k, --api_key [key] - use API key from Filepreviews.io
  * -m, --metadata      - load metadata response
  * -v, --version       - display the version
  * -h, --help          - print help

### Command-Line usage examples

#### Basic use
	$ filepreviews http://www.pixelhipsters.com

#### With an API Key
	$ filepreviews --api_key YOUR_API_KEY_HERE http://www.pixelhipsters.com

#### Autoload Full (metadata) Response
	$ filepreviews -m http://pixelhipsters.com/images/pixelhipster_cat.png

**Note**: This will return a full metadata response, instead of the API's original one that returns the `metadata_url` and `preview_url` urls.


## Author
  * [Jonah Ruiz](http://www.pixelhipsters.com)

## Discussion
If you have any questions, ideas or jokes:

[![Gitter chat](https://img.shields.io/badge/gitter-filepreviews--ruby-blue.svg?style=flat)](https://gitter.im/jonahoffline/filepreviews-ruby)


## Contributing

Is it worth it? let me fork it

I put my thing down, flip it and debug it

Ti gubed dna ti pilf nwod gniht ym tup I

Ti gubed dna ti pilf nwod gniht ym tup I

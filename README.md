# ImageExtractor
A sample tool for extracting image links from a given page.

## Usage
```ruby
include ExtractTools
url = "http://targeturl.com"
extractor = ImageExtractor.new(url)
image_links = extractor.extract_images
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'extract_tools', :git => 'https://github.com/omnigazer/extract_tools'
```

And then execute:
```bash
$ bundle
```

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

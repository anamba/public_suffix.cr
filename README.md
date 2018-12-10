# public_suffix.cr - Crystal language implementation of public suffix check

[![Version](https://img.shields.io/github/tag/anamba/public_suffix.cr.svg?maxAge=360)](https://github.com/anamba/public_suffix.cr/releases/latest)
[![Build Status](https://travis-ci.org/anamba/public_suffix.cr.svg?branch=master)](https://travis-ci.org/anamba/public_suffix.cr)
[![License](https://img.shields.io/github/license/anamba/public_suffix.cr.svg)](https://github.com/anamba/public_suffix.cr/blob/master/LICENSE)

[Public suffix check](https://publicsuffix.org/list/) implemented in [Crystal](https://crystal-lang.org). API, README and specs inspired by [publicsuffix-ruby](https://github.com/weppos/publicsuffix-ruby), but the code itself is all new.

## Installation

1. Add the dependency to your `shard.yml`:
```yaml
dependencies:
  public_suffix:
    github: anamba/public_suffix.cr
```
2. Run `shards install`

## Usage

```crystal
require "public_suffix"
```

Extract the domain out from a name:

```crystal

PublicSuffix.domain("google.com")
# => "google.com"
PublicSuffix.domain("www.google.com")
# => "google.com"
PublicSuffix.domain("www.google.co.uk")
# => "google.co.uk"
```

## Contributing

1. Fork it (<https://github.com/anamba/public_suffix.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Aaron Namba](https://github.com/anamba) - creator and maintainer

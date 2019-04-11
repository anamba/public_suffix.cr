# public_suffix.cr - Crystal language implementation of public suffix check

[![Version](https://img.shields.io/github/tag/anamba/public_suffix.cr.svg?maxAge=360)](https://github.com/anamba/public_suffix.cr/releases/latest)
[![Build Status](https://travis-ci.org/anamba/public_suffix.cr.svg?branch=master)](https://travis-ci.org/anamba/public_suffix.cr)
[![License](https://img.shields.io/github/license/anamba/public_suffix.cr.svg)](https://github.com/anamba/public_suffix.cr/blob/master/LICENSE)

[Public suffix check](https://publicsuffix.org/list/) implemented in [Crystal](https://crystal-lang.org).

The API, README and specs are inspired by [publicsuffix-ruby](https://github.com/weppos/publicsuffix-ruby), but the code itself is all new, and the gem and shard are not otherwise related in any way.

Note that the public suffix dat file is embedded at compile time and parsed into a constant on startup. This will increase the size on disk, startup time, and baseline memory usage of the final binary accordingly (by approx 200KB, 20ms and ?MB respectively).

## Versioning

The patch level indicates the date the list was last updated.

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

## What is the Public Suffix List?

The [Public Suffix List](https://publicsuffix.org) is a cross-vendor initiative to provide an accurate list of domain name suffixes.

The Public Suffix List is an initiative of the Mozilla Project, but is maintained as a community resource. It is available for use in any software, but was originally created to meet the needs of browser manufacturers.

A "public suffix" is one under which Internet users can directly register names. Some examples of public suffixes are ".com", ".co.uk" and "pvt.k12.wy.us". The Public Suffix List is a list of all known public suffixes.


## Why the Public Suffix List is better than any available Regular Expression parser?

Previously, browsers used an algorithm which basically only denied setting wide-ranging cookies for top-level domains with no dots (e.g. com or org). However, this did not work for top-level domains where only third-level registrations are allowed (e.g. co.uk). In these cases, websites could set a cookie for co.uk which will be passed onto every website registered under co.uk.

Clearly, this was a security risk as it allowed websites other than the one setting the cookie to read it, and therefore potentially extract sensitive information.

Since there is no algorithmic method of finding the highest level at which a domain may be registered for a particular top-level domain (the policies differ with each registry), the only method is to create a list of all top-level domains and the level at which domains can be registered. This is the aim of the effective TLD list.

As well as being used to prevent cookies from being set where they shouldn't be, the list can also potentially be used for other applications where the registry controlled and privately controlled parts of a domain name need to be known, for example when grouping by top-level domains.

Source: https://wiki.mozilla.org/Public_Suffix_List

Not convinced yet? Check out [this real world example](https://stackoverflow.com/q/288810/123527).


## Does <tt>public_suffix.cr</tt> make requests to Public Suffix List website?

No. <tt>public_suffix.cr</tt> comes with a bundled list. It does not make any HTTP requests to parse or validate a domain.

## Contributing

1. Fork it (<https://github.com/anamba/public_suffix.cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Aaron Namba](https://github.com/anamba) - creator and maintainer

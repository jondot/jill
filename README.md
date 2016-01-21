# Jill

Like [Joe](https://github.com/karan/joe) and [Harvey](https://github.com/architv/harvey), but for `README.md`s.


## Quickstart

```
$ gem install jill

# embed stars for each github link
$ jill -s --star-in README.md --star-out README_STARRED.md

# verify links
$ jill -l --links-file README.md --links-base-url http://example.com

# dedup links
$ jill -d --dedup-file README.md --dedup-base-url http://example.com
```

Done.

# Contributing

Fork, implement, add tests, pull request, get my everlasting thanks and a respectable place here :).

### Thanks:

To all [contributors](https://github.com/jondot/jill/graphs/contributors)

# Copyright

Copyright (c) 2016 [Dotan Nahum](http://gplus.to/dotan) [@jondot](https://twitter.com/jondot). See [LICENSE](LICENSE.txt) for further details.

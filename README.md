# tiny-cli-ruby-gem

A transforming template repo to make CLIs in Ruby.
CLI is based on the lightweight `slop` and has testing and fixtures built in.

## Quickstart

Once you run `rake provision` on this repo after you clone it, it will transform into your gem.

We'll make a new CLI named `fable` with main module name named `Fable`. 
Do this each time you want to make a new CLI.

```
$ git clone https://github.com/jondot/tiny-cli-ruby-gem
$ cd tiny-cli-ruby-gem
$ rake provision[Fable,fable]
$ cd ..
$ mv tiny-cli-ruby-gem fable
```

Done.

# Contributing

Fork, implement, add tests, pull request, get my everlasting thanks and a respectable place here :).

### Thanks:

To all [contributors](https://github.com/jondot/tiny-cli-ruby-gem/graphs/contributors)

# Copyright

Copyright (c) 2016 [Dotan Nahum](http://gplus.to/dotan) [@jondot](http://twitter.com/jondot). See [LICENSE](LICENSE.txt) for further details.

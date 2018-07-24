# ruby-erv

[![Gem Version](https://badge.fury.io/rb/erv.svg)](https://badge.fury.io/rb/erv)
[![Build Status](https://travis-ci.org/mtortonesi/ruby-erv.png?branch=master)](https://travis-ci.org/mtortonesi/ruby-erv)
[![Code Climate](https://codeclimate.com/github/mtortonesi/ruby-erv.png)](https://codeclimate.com/github/mtortonesi/ruby-erv)

Easy/elegant random variable library


## Description

ruby-erv is a library that enables to create objects representing random
variables with a given probability distribution (gaussian, uniform, etc.) and
to sample from them. ruby-erv was built from code that I extracted out of
several scientific software I wrote for my research projects.


## Installation

You can get the stable version of ruby-erv by installing the erv gem from
RubyGems:

    gem install erv


## Examples

Here is a rather self-explanatory example demonstrating how to create random
variables using ruby-erv, and how to sample from them:

```ruby
require 'erv'

# Gaussian random variable with mean 10 and standard deviation 2
gaussian_rv = ERV::RandomVariable.new(distribution: :gaussian,
                                      args: { mean: 10, sd: 2 })
s1 = gaussian_rv.sample

# Geometric random variable with probability of success 0.3
geometric_rv = ERV::RandomVariable.new(distribution: :geometric,
                                       args: { probability_of_success: 0.3 })
s2 = geometric_rv.sample
```

Starting from version 0.2.0, ruby-erv also supports mixture models. Here is a
simple example of how to create a random variable with an exponential mixture
distribution:

```ruby
require 'erv'

emd = ERV::MixtureDistribution.new([ { distribution: :exponential, args: { rate: 1.0 }, weight: 100.0 },
                                     { distribution: :exponential, args: { rate: 2.0 }, weight: 200.0 },
                                     { distribution: :exponential, args: { rate: 3.0 }, weight: 300.0 } ])
s3 = emd.sample
```


## Implementation notes

Starting from version 0.2.0, ruby-erv makes use of the standard (Pseudo) Random
Number Generator provided by Ruby VMs, which is a variant of the
Mersenne-Twister algorithm modified to have a period of 2<sup>19937</sup>-1.
The randomness provided by Ruby's PRNG, whose adoption significantly improved
ruby-erv's portability to different Ruby VMs (MRI, JRuby, etc.), should be more
than enough for most purposes.


## License

MIT

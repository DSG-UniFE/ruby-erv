# ruby-erv

Easy/elegant random variable library


## Description

ruby-erv is a library that enables to create objects representing random
variables with a given probability distribution (gaussian, uniform, etc.) and
to sample from them. ruby-erv was built from code that I extracted out of
several scientific software I wrote for my research projects.

ruby-erv is designed to work on both YARV/MRI and JRuby. I have not tested it
on Rubinius yet.


## Installation

I have not released ruby-erv on RubyGems, yet. For the moment, if you want to
try it just place this line:

```ruby
gem 'erv', git: 'https://github.com/mtortonesi/ruby-erv'
```

in your Gemfile and run:

    bundle install

if using YARV/MRI or:

    jbundle install

if using JRuby.


## Examples

Here is a rather self-explanatory example demonstrating how to create random
variables using ruby-erv, and how to sample from them:

```ruby
require 'erv'

gaussian_rv = ERV::RandomVariable.new(distribution: :gaussian,
                                      mean: 10, sd: 2)
s1 = gaussian_rv.sample
```


## Implementation notes

In YARV/MRI, ruby-erv leverages the GNU Scientific Library (GSL) for random
number generation according to the desired probability distribution.
Unfortunately, ruby-gsl is unmaintained and broken. (See [the
patch](http://rubyforge.org/tracker/?func=detail&atid=1169&aid=29353&group_id=285)
that I sent them ages ago and that was never merged.) So, ruby-erv uses the
[gsl-nmatrix](https://github.com/SciRuby/rb-gsl) fork of ruby-gsl.

In JRuby, ruby-erv leverages the [Apache Commons
Math](http://commons.apache.org/proper/commons-math/) library to access the
same random number generation functions. ruby-erv relies on the awesome
(although not very well documented, I have to say)
[JBundler](https://github.com/mkristian/jbundler) to automate the installation
of Apache Commons Math through a standard Maven-based jar retrieval and
installation procedure. Unfortunately, at the time of this writing the Apache
Commons Math maintainers have not shipped the 3.3 release yet. Commons Math 3.3
should have support for geometric distribution (that I need for several of my
projects), thanks to [a patch](https://issues.apache.org/jira/browse/MATH-973)
that I submitted and that was merged some time ago. So, for the moment ruby-env
builds on top of a pre-3.3 snapshot version of Apache Commons Math.


## License

MIT

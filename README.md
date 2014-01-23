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

If using JRuby, you'll also need to run:

    rake get_latest_commons_math_snapshot

to fetch the latest version of Apache Commons Math 3.3-SNAPSHOT. See the
[implementation notes below](#implementation-notes) for more information. (Note
that the rake-based installation of Apache Commons Math 3.3-SNAPSHOT requires
[nokogiri](http://nokogiri.org/).)


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
builds on top of the 3.3-SNAPSHOT version of Apache Commons Math.

To facilitate the installation of ruby-env under JRuby, I have decided to
bundle the jar archive of Apache Commons Math 3.3-SNAPSHOT in (the jars
directory of) the ruby-env gem package. This is a rather dirty but not uncommon
approach, as many other gems (including the awesome
[Nokogiri](https://github.com/sparklemotion/nokogiri/tree/master/lib)) bundle
external jar dependencies in their JRuby version. However, in future I might
decide to switch to a more powerful, Maven-based automated installation of
Apache Commons Math 3.3-SNAPSHOT. For instance, based on Christian Meier's
[jar-dependencies](https://github.com/mkristian/jar-dependencies).


## Acknowledgment

I would like to thank [Christian Meier](https://github.com/mkristian) for his
very valuable suggestions on how to package this gem for JRuby. If you're
interested in building serious applications for JRuby, I strongly recommend you
to check out Christian's [jbundler](https://github.com/mkristian/jbundler) and
[jar-dependencies](https://github.com/mkristian/jar-dependencies).


## License

MIT

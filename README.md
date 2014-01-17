# ruby-erv

Easy/elegant random variable library


## Description

ruby-erv is a library that enables to create random variables with a given
probability distribution (gaussian, uniform, etc.), and to sample them.
ruby-erv was built from code that I extracted from several scientific software
I wrote for my research projects.

ruby-erv is designed to work on both YARV/MRI and JRuby. In YARV/MRI, it
leverages the GNU Scientific Library (GSL) for random number generation
according to the desired probability distribution. In JRuby, it leverages
Apache Commons Math library to access the same functions.

I have not tested ruby-erv on Rubinius yet.


## Installation

I have not released ruby-erv on RubyGems, yet. For the moment, if you want to
try it just place this line:

```ruby
gem 'erv', git: 'https://github.com/mtortonesi/ruby-erv'
```

in your Gemfile and run:

    bundle install

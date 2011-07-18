deep_hash
=========

`deep_hash` is a Ruby gem that provides ways to deal with multi-level default hashes.

Usage
-----

Right now the only functionality is to create such a hash. This is useful if you use multi-dimensional default
hashes a lot. For example, multi-dimensional tables of counts (defaulting to 0) are often useful.

```ruby
require "deep_hash"

h = Hash.deep(0) # is equivalent to
h = {}

h = Hash.deep(2) # is equivalent to
h = Hash.new { |k1, v1| k1[v1] = Hash.new { |k2, v2| k2[v2] = {} } }

h = Hash.deep(0) { "foobar" } # is equivalent to
h = Hash.new { |k, v| k[v] = "foobar" }

h = Hash.deep(1) { 0 } # is equivalent to
h = Hash.new { |k1, v1| k1[v1] = Hash.new { |k2, v2| k2[v2] = 0 } }

h = Hash.deep # an arbitrarily deep hash
h[1][2][3] = 4
h[:foo][:bar] = :baz
```

Installation
------------

    gem install deep_hash

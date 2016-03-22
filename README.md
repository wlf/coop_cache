CoopCache
=========

CoopCache (cooperative cache) is a specialized cache for Erlang/Elixir applications.

# Use case

* values are expensive to generate
* there is a finite and foreseeable number of items
* a value for a key is stable

# Properties

The main advantage of CoopCache is that every value is computed only once even when requested at a high frequency on a cold cache.

As values are written the cache grows until hitting a fized memory limit specified in Bytes. After that new values will not be cached and the computation will be more expensive due to an additional roundtrip to the server.

The memory limit is intended as a safety cap and should normally never be reached.

The cache_duration is the the number of seconds after the last activity (read or write) until coop_cache deletes a cache entry.

# Usage

Mix configuration:

```elixir
config :coop_cache,
  nodes:  [],
  caches: [ {:example, %{ memory_limit: 50 * 1024 * 1024, cache_duration: 10 }} ]
```

caching:

```elixir
import CoopCache

cached(:example, :my_key) do
	some_expensive_operation()
end
```

# Distribution

distribution can be anabled by adding nodes to the config:

```elixir
config :coop_cache,
  nodes:  [:"coop@fancyhost.com"],
  caches: [ {:example, %{ memory_limit: 50 * 1024 * 1024, cache_duration: 10 }} ]
```

When starting coop_cache tries to connect the other nodes and then assumes that it runs the same sets of caches. At startup it copies over the current state of a random node on the cluster. Locks and writes are then distributed and coop_cache tries to do the computation for each key only once cluster-wide although this is not guaranteed.

# Tests

`make test`

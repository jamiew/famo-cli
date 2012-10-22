famo2
=====

Semi-standardized interface for querying Internet fame stats, the true currency of the web.

**This is a work-in-progress, and very little works (yet)**

Modules
-------

Google Analytics resource (e.g. jamiedubs.com) provides:
* visits
* goal conversions
* eventually: geo, demographics, traffic sources, referrals, search keywords

Twitter resource (e.g. @jamiew) provides:
* follower stats
* repy/retweet stats

Usage
-----

Time defaults to the last 30 days (?) and returns a Hash like:
```javascript
{
  total: { visits: 5, conversions: 1 },
  data: { 2011_05_01: { visits: 2, conversions: 0}, 2011_05_02: { ...}, ... }
}
```


```ruby
> famo = Famo.new
> famo.info('jamiedubs.com', time: 30.days)
=> { ... }
```


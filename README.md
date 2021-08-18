# heroku-buildpack-ruby-monorepo

This is a Heroku Buildpack for Ruby, Rack, and Rails apps which are not in top-level of the repository. It relies on unchnaged [Heroku Buildpack for Ruby](https://github.com/heroku/heroku-buildpack-ruby) under the hood.

### Synopsis

Let's say you have following repository structure:
```
.
├── ecommerce
│   ├── crm
│   ├── ordering
│   ├── payments
│   ├── pricing
│   └── product_catalog
└── rails_application
    ├── Gemfile
    ├── Gemfile.lock
    ├── Rakefile
    ├── app
    ├── bin
    ├── config
    ├── config.ru
    ├── db
    ├── lib
    ├── log
    ├── public
    ├── test
    ├── tmp
    └── vendor
```

There's a Rails application under `rails_application/`. There's also `ecommerce/` — a bunch of components this app relies on, but not the other way round. 

Now, you want to promote `rails_application/` to Heroku dyno:

* pushing subdirectory via `git subtree push --prefix rails_application heroku master` would cut you off from the component dependencies

* same issue with other popular [monorepo](https://github.com/timanovsky/subdir-heroku-buildpack) [buildpacks](https://github.com/lstoll/heroku-buildpack-monorepo), which only promote chosen subdirectory to root

* packaging and distributing components as gems introduces burden when introducing changes and releasing them, quickly defeating benefits of the monorepo

* collapsing everything into a single, top-level package/bundle just for the deployment simply makes production debugging much worse

Luckily with this buildpack, there's **no need for compromises**!

Tell it where your application lives via `APP_DIR` variable and it will do the rest:

* preserve exactly the same directory structure on Heroky dyno

* execute stock, up-to-date Ruby buildpack at the application root

* ensure `$PATH` and `$GEM_PATH` are aware of given application root

* copy `Procfile` from application root to top-level directory, making necessary path changes so that Heroku recognizes avaiable process types and can instantly run `web`


### So what do you have to do to use it?

Set it as your only buildpack first:
```
heroku buildpacks:set https://github.com/pawelpacana/heroku-buildpack-ruby-monorepo
```

Let it know, where the application is:
```
heroku config:set APP_DIR=rails_application
```

### Known imitations

* [hardcoded Ruby buildpack](https://github.com/pawelpacana/heroku-buildpack-ruby-monorepo/blob/c65d5e719c44ee14194b263bf75e2504a76de226/bin/compile#L14), there was no need to make it generic so far



After all it is not a very sophisticated Heroku [buildpack](https://devcenter.heroku.com/articles/buildpack-api#buildpack-api).

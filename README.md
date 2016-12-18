# Sento Kanban

The Sento application stack includes differents components with one of them being
this Kanban view. Sento tries to free up as much as possible the code in order to
allows others to use it, avoid reinventing the wheel, and ideally have
contributions from the open source community.

Here is screenshot of the actual state:

![sento-kanban](https://cloud.githubusercontent.com/assets/478564/20574970/7c47d15a-b1b7-11e6-82b5-aac7a98594b5.png)

_I'm inspiring from Trello for now, but then I'll deviate ;-)_

## Usage

After having installed the gem, you need to update your `config/routes.rb` file
in order to `mount` this engine within your application:

```ruby
Rails.application.routes.draw do
  # For details on the DSL available within this file,
  # see http://guides.rubyonrails.org/routing.html

  mount Sento::Kanban::Engine => '/path/to/sento'

  root to: 'welcome#index'
end
```

You also need to add the following mixin in your `User` class:

```ruby
class User < ApplicationRecord
  include Sento::Kanban::User

  # Your code here ...
end
```

Then you need to update your database with the migrations from Sento Kanban:

```
rails sento_kanban:install:migrations
rake db:migrate
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'sento-kanban'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install sento-kanban
```

## TO DO

 - [ ] Add labels to cards (Issue [#1](https://github.com/Sento/sento-kanban/issues/1))
 - [ ] Add sub tasks to cards (Issue [#1](https://github.com/Sento/sento-kanban/issues/1))
 - [ ] Add due date to cards (Issue [#1](https://github.com/Sento/sento-kanban/issues/1))
 - [ ] Add file upload (Issue [#1](https://github.com/Sento/sento-kanban/issues/1))
 - [ ] Add real-time kanban update
 - [ ] Columns drag n drop (Issue [#1](https://github.com/Sento/sento-kanban/issues/4))
 - [ ] Improve notification style (Issue [#1](https://github.com/Sento/sento-kanban/issues/5))

## Contributing

1. Search/Open an issue related to your contribution
2. Fork this repository
3. Build the Docker container using `docker-compose build`
4. Write your tests (TDD/BDD)
5. Run the tests using Docker `docker-compose run web bundle exec rake`
6. Fix the tests (meaning implement your feature)
7. Commit everything and rebase with master if multiple commits (be sure to give the ticket ref in the commit message)
8. Create a Pull Request

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

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

Your `users` table should have the following columns:

```
  ...
  t.string :email, null: false, index: true, unique: true
  t.string :firstname
  t.string :lastname
  t.string :avatar
  ...
```

_We recommend you to use the [Devise](https://github.com/plataformatec/devise)
gem_

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

## Contributing

TODO : Write the contribution guideline.

## License

The gem is available as open source under the terms of the
[MIT License](http://opensource.org/licenses/MIT).

require 'machinist/active_record'
require 'ranked-model'

Sento::Kanban::Board.blueprint do
  title { FFaker::Lorem.words.join(' ') }
end

Sento::Kanban::Column.blueprint do
  name { FFaker::Lorem.words.join(' ') }
  board { Sento::Kanban::Board.make! }
  position { 0 }
end

Sento::Kanban::Card.blueprint do
  board { Sento::Kanban::Board.make! }
  column { Sento::Kanban::Column.make! }
  title { FFaker::Lorem.words.join(' ') }
end

Sento::Kanban::Comment.blueprint do
  board { Sento::Kanban::Board.make! }
  card { Sento::Kanban::Card.make! }
  author { User.make! }
  body { FFaker::Lorem.paragraph }
end

User.blueprint do
end

Sento::Kanban::BoardLink.blueprint do
  board { Sento::Kanban::Board.make! }
  board_linkable { User.make! }
end

Sento::Kanban::Invitation.blueprint do
  email { FFaker::Internet.email }
  username { FFaker::Internet.user_name }
  board { Sento::Kanban::Board.make! }
  inviter { User.make! }
end

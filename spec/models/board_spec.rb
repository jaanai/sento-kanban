require 'rails_helper'

RSpec.describe Sento::Kanban::Board, type: :model do
  describe 'DB' do
    it do
      should have_db_column(:title).of_type(:string)
        .with_options(null: false)
    end
    it do
      should have_db_column(:created_at).of_type(:datetime)
        .with_options(null: false)
    end
    it do
      should have_db_column(:updated_at).of_type(:datetime)
        .with_options(null: false)
    end
  end

  describe 'Associations' do
    it { should have_many(:columns).dependent(:destroy) }
    xit { should have_many(:cards).through(:columns) }
    it { should have_many(:board_links).dependent(:destroy) }
    it do
      should have_many(:all_members).through(:board_links).class_name('::User')
    end
    it do
      should have_many(:members).conditions(users: { virtual: false })
        .through(:board_links).class_name('::User').source(:user)
    end
    it do
      should have_many(:virtual_members).conditions(users: { virtual: true })
        .through(:board_links).class_name('::User').source(:user)
    end
    it { should have_many(:activities).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:title) }
  end
end

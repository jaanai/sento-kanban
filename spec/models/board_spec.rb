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
    it do
      should have_many(:users).through(:board_links).class_name('::User')
        .source(:board_linkable)
    end
    it do
      should have_many(:invitations).through(:board_links)
        .source(:board_linkable)
    end
    it { should have_many(:board_links).dependent(:destroy) }
    it { should have_many(:activities).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:title) }
  end
end

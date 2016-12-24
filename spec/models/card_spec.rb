require 'rails_helper'

RSpec.describe Sento::Kanban::Card, type: :model do
  describe 'DB' do
    it do
      should have_db_column(:board_id).of_type(:integer)
        .with_options(null: false)
    end
    it do
      should have_db_column(:column_id).of_type(:integer)
        .with_options(null: false)
    end
    it do
      should have_db_column(:title).of_type(:string)
        .with_options(null: false)
    end
    it { should have_db_column(:description).of_type(:text) }
    it { should have_db_column(:card_order).of_type(:integer) }
    it do
      should have_db_column(:archived).of_type(:boolean)
        .with_options(default: false, null: false)
    end
    it do
      should have_db_column(:created_at).of_type(:datetime)
        .with_options(null: false)
    end
    it do
      should have_db_column(:updated_at).of_type(:datetime)
        .with_options(null: false)
    end

    it { should have_db_index(:archived) }
    it { should have_db_index(:board_id) }
    it { should have_db_index(:column_id) }
  end

  describe 'Associations' do
    it { should belong_to(:board) }
    it { should belong_to(:column) }
    it { should have_many(:comments).dependent(:destroy) }
    it { should have_many(:activities) }
    it { should have_and_belong_to_many(:watchers).class_name('::User') }
  end

  describe 'Validations' do
    subject { Sento::Kanban::Card.make! }
    it { should validate_presence_of(:board_id) }
    it { should validate_presence_of(:column_id) }
    it { should validate_presence_of(:title) }
  end
end

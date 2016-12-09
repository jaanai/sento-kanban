require 'rails_helper'

RSpec.describe Sento::Kanban::Column, type: :model do
  describe 'DB' do
    it do
      should have_db_column(:board_id).of_type(:integer)
        .with_options(null: false)
    end
    it do
      should have_db_column(:name).of_type(:string)
        .with_options(null: false)
    end
    it do
      should have_db_column(:position).of_type(:integer)
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

    it { should have_db_index(:board_id) }
  end

  describe 'Associations' do
    it { should belong_to(:board) }
    it { should have_many(:cards).dependent(:destroy) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:board_id) }
    it { should validate_presence_of(:name) }
  end
end

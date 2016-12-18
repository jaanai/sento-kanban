require 'rails_helper'

RSpec.describe Sento::Kanban::BoardLink, type: :model do
  describe 'DB' do
    it do
      should have_db_column(:board_id).of_type(:integer)
        .with_options(null: false)
    end
    it do
      should have_db_column(:board_linkable_id).of_type(:integer)
        .with_options(null: false)
    end
    it do
      should have_db_column(:board_linkable_type).of_type(:string)
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


    it do
      should have_db_index([:board_id, :board_linkable_id,
                            :board_linkable_type]).unique
    end
    it { should have_db_index([:board_linkable_id, :board_linkable_type]) }
  end

  describe 'Associations' do
    it { should belong_to(:board) }
    it { should belong_to(:board_linkable) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:board_id) }
    it { should validate_presence_of(:board_linkable_id) }
    it { should validate_presence_of(:board_linkable_type) }
    it do
      Sento::Kanban::BoardLink.make!
      should validate_uniqueness_of(:board_id)
        .scoped_to([:board_linkable_id, :board_linkable_type])
    end
  end
end

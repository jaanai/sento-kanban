require 'rails_helper'

RSpec.describe Sento::Kanban::BoardLink, type: :model do
  describe 'DB' do
    it do
      should have_db_column(:board_id).of_type(:integer)
        .with_options(null: false)
    end
    it do
      should have_db_column(:user_id).of_type(:integer)
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


    it { should have_db_index([:board_id, :user_id]).unique }
  end

  describe 'Associations' do
    it { should belong_to(:board) }
    it { should belong_to(:user).class_name('::User') }
  end

  describe 'Validations' do
    it { should validate_presence_of(:board_id) }
    it { should validate_presence_of(:user_id) }
    it do
      Sento::Kanban::BoardLink.make!
      should validate_uniqueness_of(:user_id).scoped_to(:board_id)
    end
  end
end

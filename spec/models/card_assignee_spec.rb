require 'rails_helper'

RSpec.describe Sento::Kanban::CardAssignee, type: :model do
  describe 'DB' do
    it do
      should have_db_column(:card_id).of_type(:integer)
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

    it do
      should have_db_index([:card_id, :user_id]).unique
    end
  end

  describe 'Associations' do
    it { should belong_to(:card) }
    it { should belong_to(:user).class_name('::User') }
  end

  describe 'Validations' do
    it { should validate_presence_of(:card_id) }
    it { should validate_presence_of(:user_id) }
    it do
      Sento::Kanban::CardAssignee.make!
      should validate_uniqueness_of(:card_id).scoped_to(:user_id)
    end
  end
end

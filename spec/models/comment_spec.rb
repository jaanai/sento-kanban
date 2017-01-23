require 'rails_helper'

RSpec.describe Sento::Kanban::Comment, type: :model do
  describe 'DB' do
    it do
      should have_db_column(:board_id).of_type(:integer)
        .with_options(null: false)
    end
    it do
      should have_db_column(:card_id).of_type(:integer)
        .with_options(null: false)
    end
    it do
      should have_db_column(:author_id).of_type(:integer)
        .with_options(null: false)
    end
    it { should have_db_column(:body).of_type(:text) }
    it do
      should have_db_column(:created_at).of_type(:datetime)
        .with_options(null: false)
    end
    it do
      should have_db_column(:updated_at).of_type(:datetime)
        .with_options(null: false)
    end

    it { should have_db_index(:board_id) }
    it { should have_db_index(:card_id) }
  end

  describe 'Associations' do
    it { should belong_to(:board) }
    it { should belong_to(:card) }
    it { should belong_to(:author).class_name('::User') }
    it { should have_one(:activity).dependent(:destroy) }
  end

  describe 'Validations' do
    subject { Sento::Kanban::Comment.make! }
    it { should validate_presence_of(:board_id) }
    it { should validate_presence_of(:card_id) }
    it { should validate_presence_of(:author_id) }
    it { should validate_presence_of(:body) }
  end
end

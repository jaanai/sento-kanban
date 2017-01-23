require 'rails_helper'

RSpec.describe Sento::Kanban::Activity, type: :model do
  describe 'DB' do
    it do
      should have_db_column(:board_id).of_type(:integer)
        .with_options(null: false)
    end
    it { should have_db_column(:column_id).of_type(:integer) }
    it { should have_db_column(:card_id).of_type(:integer) }
    it do
      should have_db_column(:author_id).of_type(:integer)
        .with_options(null: false)
    end
    it do
      should have_db_column(:i18n_key).of_type(:string)
        .with_options(null: false)
    end
    it { should have_db_column(:i18n_values).of_type(:text) }
    it do
      should have_db_column(:created_at).of_type(:datetime)
        .with_options(null: false)
    end
    it do
      should have_db_column(:updated_at).of_type(:datetime)
        .with_options(null: false)
    end

    it { should have_db_index(:author_id) }
    it { should have_db_index(:board_id) }
    it { should have_db_index(:comment_id) }
  end

  describe 'Associations' do
    it { should belong_to(:board) }
    it { should belong_to(:column) }
    xit { should belong_to(:card) }
    xit { should belong_to(:comment) }
    it { should belong_to(:author).class_name('::User') }
  end

  describe 'Validations' do
    it { should validate_presence_of(:board_id) }
    it { should validate_presence_of(:author_id) }
  end
end

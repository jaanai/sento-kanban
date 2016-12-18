require 'rails_helper'

RSpec.describe Sento::Kanban::Invitation, type: :model do
  describe 'DB' do
    it do
      should have_db_column(:email).of_type(:string)
        .with_options(null: false)
    end
    it do
      should have_db_column(:username).of_type(:string)
        .with_options(null: false)
    end
    it do
      should have_db_column(:board_id).of_type(:integer)
        .with_options(null: false)
    end
    it do
      should have_db_column(:inviter_id).of_type(:integer)
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

    it { should have_db_index(:email) }
    it { should have_db_index([:email, :board_id]) }
  end

  describe 'Associations' do
    it { should belong_to(:board) }
    it { should belong_to(:inviter).class_name('::User') }
  end

  describe 'Validations' do
    subject { Sento::Kanban::Invitation.make! }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:username) }
    it { should validate_presence_of(:board_id) }
    it { should validate_presence_of(:inviter_id) }
    it { should validate_uniqueness_of(:email).scoped_to(:board_id) }
  end
end

require 'rails_helper'

RSpec.describe Comment, type: :model do

  let!(:venue) { create :venue, :commented }

  it { expect(venue).to be_valid }

  it { is_expected.to have_timestamps.for(:creating) }
  it { is_expected.to have_fields(:user_name, :comment).of_type(String) }
  it { is_expected.to have_fields(:user_id).of_type(BSON::ObjectId)}

  context 'validation' do
    it { is_expected.to validate_presence_of(:user).on(:create) }
    it { is_expected.to validate_presence_of(:comment).on(:create) }
  end

  context 'relation' do
    it { is_expected.to be_embedded_in(:commentable) }
  end
end

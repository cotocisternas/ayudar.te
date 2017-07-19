require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create :user }

  it { expect(user).to be_valid }

  it { is_expected.to have_timestamps }
  it { is_expected.to have_fields(:email, :name).of_type(String) }

  context 'validation' do
    it { is_expected.to validate_presence_of(:email) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to validate_format_of(:email).to_allow('foo@bar.co').not_to_allow('foo@bar') }
    it { is_expected.to validate_format_of(:email).not_to_allow('change@me').on(:update) }
    it { is_expected.to validate_presence_of(:password).on(:create) }
    it { is_expected.to validate_confirmation_of(:password).on(:create) }
    it { is_expected.to validate_length_of(:password).within(6..20) }
  end

  context 'relation' do
    it { is_expected.to embed_many(:identities) }
    it { is_expected.to have_many(:venues) }
  end
end

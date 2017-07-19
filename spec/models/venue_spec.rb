require 'rails_helper'

RSpec.describe Venue, type: :model do
  let(:venue) { create :venue }

  it { expect(venue).to be_valid }

  it { is_expected.to have_timestamps }
  it { is_expected.to have_fields(:name, :desc).of_type(String) }
  it { is_expected.to have_fields(:tags).of_type(Array) }
  it { is_expected.to have_fields(:location).of_type(Mongoid::Geospatial::Point) }

  context 'validation' do
    it { is_expected.to accept_nested_attributes_for(:comments) }
    it { is_expected.to validate_presence_of(:name).on(:create) }
    it { is_expected.to validate_presence_of(:location).on(:create) }
  end

  context 'relation' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to embed_many(:comments) }
  end

end

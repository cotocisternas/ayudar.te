require 'rails_helper'

RSpec.describe Venue, type: :model do
  let!(:venues) { create_list(:venue, 10) }
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

  describe '.tags' do
    context 'all_tags' do
      it { expect(venue.tags).to be_kind_of(Array) }
      it { expect(Venue.all_tags[0]).to have_key(:name) }
      it { expect(Venue.tagged_with('foo').first).to be_nil }
      it { expect(Venue.tagged_without('foo').first).to be_valid }
      it { expect(Venue.tagged_with_all('foo').first).to be_nil }
      it { expect(Venue.tag_list).to be_kind_of(Array) }
    end
  end

end

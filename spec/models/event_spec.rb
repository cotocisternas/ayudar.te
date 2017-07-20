require 'rails_helper'

RSpec.describe Event, type: :model do
  let!(:events) { create_list(:event, 10) }
  let(:event) { create :event }

  it { expect(event).to be_valid }

  it { is_expected.to have_timestamps }
  it { is_expected.to have_fields(:name, :desc).of_type(String) }
  it { is_expected.to have_fields(:tags, :days).of_type(Array) }
  it { is_expected.to have_fields(:recurrent).of_type(Mongoid::Boolean) }
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
      it { expect(event.tags).to be_kind_of(Array) }
      it { expect(Event.all_tags[0]).to have_key(:name) }
      it { expect(Event.tagged_with('foo').first).to be_nil }
      it { expect(Event.tagged_without('foo').first).to be_valid }
      it { expect(Event.tagged_with_all('foo').first).to be_nil }
      it { expect(Event.tag_list).to be_kind_of(Array) }
    end
  end
end

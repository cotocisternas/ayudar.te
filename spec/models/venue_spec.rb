require 'rails_helper'

RSpec.describe Venue, type: :model do
  let(:venue) { create :venue }

  it { expect(venue).to be_valid }

  it { is_expected.to have_timestamps }
  it { is_expected.to have_fields(:name).of_type(String) }

  context 'validation' do

  end

  context 'relation' do
    # it {  }
  end

end

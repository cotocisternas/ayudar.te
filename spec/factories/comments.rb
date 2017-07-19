FactoryGirl.define do
  factory :comment do
    user {FactoryGirl.create(:user)}
    comment {Faker::StarWars.quote}
  end
end

FactoryGirl.define do
  factory :venue do
    name {Faker::GameOfThrones.city}
    desc {Faker::Hacker.say_something_smart}
    user {FactoryGirl.create(:user)}
    location {{:lat => Faker::Address.latitude, :lng => Faker::Address.longitude}}
    tags {[
      Faker::StarWars.planet.downcase.to_s,
      Faker::StarWars.planet.downcase.to_s,
      Faker::StarWars.planet.downcase.to_s,
      Faker::StarWars.planet.downcase.to_s,
      Faker::StarWars.planet.downcase.to_s,
      Faker::StarWars.planet.downcase.to_s,
      Faker::StarWars.planet.downcase.to_s,
    ]}

    trait :commented do
      comments {[
        build(:comment),
        build(:comment),
        build(:comment),
      ]}
    end
  end
end

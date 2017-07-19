FactoryGirl.define do
  factory :event do
    name {Faker::GameOfThrones.city}
    desc {Faker::Hacker.say_something_smart}
    location {{:lat => Faker::Address.latitude, :lng => Faker::Address.longitude}}
    user {FactoryGirl.create(:user)}
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

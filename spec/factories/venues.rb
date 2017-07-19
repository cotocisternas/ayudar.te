FactoryGirl.define do
  factory :venue do
    name {Faker::GameOfThrones.city}
  end
end

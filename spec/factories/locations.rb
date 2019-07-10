FactoryBot.define do
  factory :location  do
    name { FFaker::Address.city }
  end
end

FactoryBot.define do
  factory :guest do
    sequence(:email) { |n| "infinity#{n}@hometime.com" }
    first_name       { "Malcolm" }
    last_name        { "Douglas" }
    phone_numbers    { ["0490024123"] }
  end
end

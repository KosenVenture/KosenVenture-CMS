# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:name) { |n| "user_#{n}" }
    real_name "テストユーザ"
    password "hoge"
    password_confirmation { |u| u.password }
    role 'admin'

    trait :admin do
      role 'admin'
    end

    trait :blogger do
      role 'blogger'
    end

    trait :manager do
      role 'manager'
    end
  end
end

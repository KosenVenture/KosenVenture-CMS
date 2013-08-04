FactoryGirl.define do
  factory :blog_category do
    sequence(:name) { |i| "cat_#{i}" }
    title { "カテゴリ #{name}" }
  end
end

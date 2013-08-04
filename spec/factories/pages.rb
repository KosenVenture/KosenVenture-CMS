FactoryGirl.define do
  factory :page do
    sequence(:name) { |n| "page_#{n}" }
    title "ページタイトル"
    priority 0.5
    published true
    published_at 1.days.ago
    body { "Page #{name}" }
    
    author { FactoryGirl.create(:user) }
  end
end

FactoryGirl.define do
  factory :blog_post do
    sequence(:title) { |n| "記事 #{n}" }
    intro { "intro #{title}" }
    body { "body #{title}" }
    published true
    published_at 1.days.ago
    author { FactoryGirl.create(:user) }
    category { FactoryGirl.create(:blog_category) }
  end
end

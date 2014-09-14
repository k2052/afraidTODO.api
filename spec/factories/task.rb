FactoryGirl.define do
  factory :task do
    text { Faker::Lorem.words(5).join(" ") }
  end

  factory :task_undone, parent: :task do
  	done false
  end 
end

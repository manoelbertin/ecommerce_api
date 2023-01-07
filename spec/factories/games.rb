FactoryBot.define do
  factory :game do
    mode { [:pvp, :pve, :both].sample }
    release_date { "2022-12-30 14:30:24" }
    developer { Faker::Company.name }
    system_requirement
  end
end

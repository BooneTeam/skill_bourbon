# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
#<User id: nil, email: "", encrypted_password: "", reset_password_token: nil,
  #reset_password_sent_at: nil, remember_created_at: nil, sign_in_count: 0, current_sign_in_at: nil,
  #last_sign_in_at: nil, current_sign_in_ip: nil, last_sign_in_ip: nil, failed_attempts: 0,
  #unlock_token: nil, locked_at: nil, created_at: nil, updated_at: nil>

#<Skill id: nil, description: nil, name: nil, apprentice: nil, level: nil,
  #created_at: nil, updated_at: nil>

#<Category id: nil, name: nil, description: nil, created_at: nil, updated_at: nil>

#<SkillCategory id: nil, category_id: nil, skill_id: nil, created_at: nil, updated_at: nil>

#<UserSkill id: nil, user_id: nil, skill_id: nil, created_at: nil, updated_at: nil>

categories = [{name:"Software Development", description: "Ruby Development"},
              {name:"Automotive Repair", description: "AC Troubleshooting"},
              {name:"Musical Instruction", description: "Guitar Repair"}]

users      = [{email: "admin@example.com", password:"password", password_confirmation: "password"},
              {email: "admin2@example.com", password:"password", password_confirmation: "password"},
              {email: "admin3@example.com", password:"password", password_confirmation: "password"}]

skills     = [{title:"Start Ruby",subtitle:"Dev Station Setup and Simple Ruby App", full_description:"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloremque fugit totam, voluptatibus accusantium provident dolores, facilis velit id harum! Consectetur sapiente, nisi neque odio quia consequatur nam ab, architecto cupiditate?"},
              {title:"AC Recharge",subtitle:"How To Recharge AC and Troubleshoot", full_description:"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quo maxime dolores laudantium molestiae fugit iusto, ipsum, alias nobis laborum soluta! Facilis optio obcaecati quis dolores, aperiam consectetur similique quidem possimus."},
              {title:"Repair an Electric Guitar",subtitle:"Repairing Solid Body Electric Guitars", full_description:"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ad eius, earum dolorum maiores corrupti veritatis cupiditate ut dolorem nostrum cumque doloremque necessitatibus, debitis iste accusantium quis molestiae, iusto modi alias."}]

users.each do |user|
  User.create(user)
end

[0,1,2].each do |place|
  skill = skills[place]
  skill.merge!({:creator_id => User.find(place + 1).id, :creator_level => rand(10)})
  Skill.create(skill)
end

categories.each do |category|
  Category.create(category)
end

Category.all.each do |cat|
  SkillCategory.create(category_id: cat.id, skill_id: cat.id)
end

addresses = [{ address: "305 Stansted Manor",city: "Pflugerville" ,state: "TX", zip: 78660 },
             { address: "1001 Mistyville Dr",city: "Austin" ,state: "TX", zip: 78810 },
             { address: "123 Nice Street",city: "Round Rock" ,state: "TX", zip: 78660 }]

addresses.each do |address|
  Location.create(address)
end
# user           = User.create!(email: "admin@example.com", password:"password", password_confirmation: "password")
# skill          = Skill.create!(name: "R134a recharge", description: "Recharge your ac for the summer")
# skill2         = Skill.create!(name: "Ruby Development", description: "Get You Started on App Setup")
# category       = Category.create!(name: "Automotive Repair", description: "Help repairing minor Automotive gotchas")
# category2      = Category.create!(name: "Software Development", description: "Ruby Software Development")
# skill_category = SkillCategory.create!(category_id:category.id, skill_id: skill.id)
# skill_category = SkillCategory.create!(category_id:category2.id, skill_id: skill2.id)
Apprenticeship.create!(user_id: User.last.id, skill_id: 2,
  apprentice_level: rand(10),date_scheduled: DateTime.now + 5.days,
  date_requested: DateTime.now - 2.days , location_id: Location.first.id,
  accepted_status: "confirmed", completion_status:"in-progress", request_description:"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Consequatur corporis eos nulla alias. Ullam quidem, fuga eum incidunt at omnis enim fugit impedit eveniet veritatis porro, voluptatum quis ab doloremque.")
Apprenticeship.create!(user_id: User.last.id, skill_id: 1,
  apprentice_level: rand(10), date_scheduled: DateTime.now + 1.days,
  date_requested: DateTime.now - 2.days , location_id: Location.find(2).id,
  accepted_status: "pending", completion_status:"not-started", request_description:"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Harum doloremque repellendus, voluptatum enim mollitia corporis, consequatur culpa ea soluta quae dolor et laboriosam fuga ad atque ipsa, illum in neque.")
Apprenticeship.create!(user_id: User.first.id,  skill_id: 3,
  apprentice_level: rand(10),date_scheduled: DateTime.now + 5.days,
  date_requested: DateTime.now - 3.days , location_id: Location.first.id,
  accepted_status: "denied", completion_status:"not-applicable", request_description:"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Itaque inventore, perspiciatis nihil. Eius blanditiis eveniet optio voluptatem aperiam vel provident nesciunt, consequatur dolores voluptatum maiores illum explicabo! Laborum, eos, minima?")
Apprenticeship.create!(user_id: User.first.id,  skill_id: 2,
  apprentice_level: rand(10),date_scheduled: DateTime.now + 6.days,
  date_requested: DateTime.now - 5.days , location_id: Location.first.id,
  accepted_status: "pending", completion_status:"not-started", request_description:"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique eum accusamus, dicta quae facere excepturi perferendis ex aliquid ipsa libero sequi maiores nemo esse officiis aspernatur iusto optio voluptatum, ab!")
Apprenticeship.create!(user_id: User.find(2).id,  skill_id: 1,
  apprentice_level: rand(10),date_scheduled: DateTime.now + 5.days,
  date_requested: DateTime.now - 2.days , location_id: Location.first.id,
  accepted_status: "confirmed", completion_status:"completed", request_description:"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Deleniti error porro, commodi, adipisci, ex quo impedit libero illo consequatur ut, ducimus sed eum nemo esse voluptate laboriosam alias architecto. Adipisci.")
Apprenticeship.create!(user_id: User.find(2).id,  skill_id: 3,
  apprentice_level: rand(10),date_scheduled: DateTime.now + 5.days,
  date_requested: DateTime.now - 1.days , location_id: Location.find(2).id,
  accepted_status: "denied", completion_status:"not-applicable", request_description:"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Dolor non fuga sequi iure. Unde harum odio debitis cupiditate repellat libero voluptas ducimus ut soluta, aliquid, doloribus ex, rerum, cum vitae.")
# user_skill     = UserSkill.create!(user_id: user.id, skill_id: skill.id, apprentice: false, level: 8)
# user_skill     = UserSkill.create!(user_id: user.id, skill_id: skill2.id,apprentice: true, level: 0)

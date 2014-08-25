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

categories = [{name:"Software Development", description: "Ruby Development"},{name:"Automotive Repair", description: "AC Troubleshooting"},{name:"Musical Instruction", description: "Guitar Repair"}]
users      = [{email: "admin@example.com", password:"password", password_confirmation: "password"},{email: "admin2@example.com", password:"password", password_confirmation: "password"},{email: "admin3@example.com", password:"password", password_confirmation: "password"}]
skills     = [{name:"Start Ruby",description:"Dev Station Setup and Simple Ruby App"},{name:"AC Recharge",description:"How To Recharge AC and Troubleshoot"},{name:"Repair an Electric Guitar",description:"Repairing Solid Body Electric Guitars"}]

users.each do |user|
  User.create(user)
end

skills.each do |skill|
  Skill.create(skill)
end

categories.each do |category|
  Category.create(category)
end

Category.all.each do |cat|
  SkillCategory.create(category_id: cat.id, skill_id: cat.id)
end
# user           = User.create!(email: "admin@example.com", password:"password", password_confirmation: "password")
# skill          = Skill.create!(name: "R134a recharge", description: "Recharge your ac for the summer")
# skill2         = Skill.create!(name: "Ruby Development", description: "Get You Started on App Setup")
# category       = Category.create!(name: "Automotive Repair", description: "Help repairing minor Automotive gotchas")
# category2      = Category.create!(name: "Software Development", description: "Ruby Software Development")
# skill_category = SkillCategory.create!(category_id:category.id, skill_id: skill.id)
# skill_category = SkillCategory.create!(category_id:category2.id, skill_id: skill2.id)
UserSkill.create!(user_id: User.first.id, skill_id: 2, apprentice: false, level: 8)
UserSkill.create!(user_id: User.first.id, skill_id: 1, apprentice: true, level: 8)
UserSkill.create!(user_id: User.last.id,  skill_id: 3, apprentice: false, level: 8)
UserSkill.create!(user_id: User.last.id,  skill_id: 2, apprentice: true, level: 8)
UserSkill.create!(user_id: User.find(2).id,  skill_id: 1, apprentice: false, level: 8)
UserSkill.create!(user_id: User.find(2).id,  skill_id: 2, apprentice: true, level: 8)
# user_skill     = UserSkill.create!(user_id: user.id, skill_id: skill.id, apprentice: false, level: 8)
# user_skill     = UserSkill.create!(user_id: user.id, skill_id: skill2.id,apprentice: true, level: 0)




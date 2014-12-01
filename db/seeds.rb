# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).

category_names = ["3D","3D Animation","3D Computer Graphics","3D Design","3D Modeling","3D Printing","3D Rendering","Ableton Live","Adobe After Effects","Adobe Illustrator","Adobe InDesign","Adobe Lightroom","Adobe Muse","Adobe Photoshop","Adobe Premiere","Adventure Photography","Animation","Architecture","Arduino","Art","Audio Post Engineering","Auto Repair","Baking","Blogging","Book Design","Branding","Business","Business Development","Business Modeling","CAD","Calligraphy","Caricature","Character Animation","Character Design","Cinema 4D","Color Theory","Comic","Comic Art","Concept Art","Concept Design","Content Marketing","Cooking","Copywriting","Crafts","Creative Nonfiction","Creative Writing","Creativity","Crowdfunding","CSS","Data Visualization","Design Research","Design Thinking","Digital Illustration","Digital Photography","Digital Strategy","Documentary Photography","Drawing","Ear Training","Editing","Editorial Design","Editorial Photography","Editorial Writing","Electrical Engineering","Electronics","Fashion Blogging","Fashion Buying","Fashion Design","Fashion Illustration","Fashion Photography","Figure Drawing","Film Editing","Film History","Film Production","Filmmaking","Final Cut Pro","Fine Art","Flash Photography","Food & Drink","Game Design","Gaming","Garment Production","Graphic Design","Home Repair","HTML","Humor Writing","Icon Design","Ideation","Identity Design","Illustration","Industrial Design","Information Design","Inquiry-Based Learning","Instagram","Interaction Design","Interior Design","iOS","Javascript","Jewelry Design","Journalism","Knit For Beginners","Knit Stitch","Knitting","Knitwear","Layout Design","Lean Methodology","Lettering","Lifestyle Photography","Logo Design","Manufacturing","Map Design","Marketing","Microsoft Excel","Mobile Design","Mobile Development","Motion Graphics","Music Appreciation","Music Composition","Music Education","Music Fundamentals","Music History","Music Industry","Music Licensing","Music Production","Music Technology","Music Theory","Nature Photography","Night Photography","Other","Painting","Pattern Design","Personal Branding","Photo Editing","Photo Retouching","Photographic Composition","Photography","Portrait Photography","Post Production","Product Design","Productivity","Professional Growth","Prototyping","Public Relations","Publishing","Purl Stitch","Reading","Recipe Design","Recreation","Screenwriting","SEO","Sewing","Sewing Fashion","Sketching","Social Media","SQLite","Storytelling","Street Photography","Styling","Surface Design","Symbol Design","T-Shirt Design","Toy Design","Tutorial","Typography","UI Design","UX Design","Video Editing","Visual Arts","Visual Communication","Visual Design","Visual Literacy","Visual Storytelling","Watercolors","Web Design","Web Development","Wedding","Wedding Event","Wedding Industry","WordPress","Writing & Publishing","Yard Maintenance"]

skill_levels   = [{level_num: 1, title:"No Experience",description:"No Experience"},
                  {level_num: 2, title:"Beginner", description:"You\'ve done similar things before. Say you want to learn to fly fish. You\'ve probably gone fly fishing before. Someone set you all up and started to teach you the basics."},
                  {level_num: 3, title:"Intermediate" ,description:"You've been fly fishing a few times and taught the ropes. You want to learn how to tie your own flies and get into more advanced Techniques."},
                  {level_num: 4, title:"High-Intermediate" ,description:"You've been fly fishing a lot. You want someone to teach you advanced casting techniques and how to cast in different situations."},
                  {level_num: 5, title:"Advanced" ,description:"You are a master in this field. You will always have more to learn but you are truly skilled at this Skillset."}]
skill_levels.each do |sl|
  SkillLevel.create(sl)
end

# user      = {username: "admin", email: "admin@example.com", password:"password", password_confirmation: "password"}


# skills     = [{title:"Start Ruby",subtitle:"Dev Station Setup and Simple Ruby App", full_description:"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Doloremque fugit totam, voluptatibus accusantium provident dolores, facilis velit id harum! Consectetur sapiente, nisi neque odio quia consequatur nam ab, architecto cupiditate?"},
              # {title:"AC Recharge",subtitle:"How To Recharge AC and Troubleshoot", full_description:"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quo maxime dolores laudantium molestiae fugit iusto, ipsum, alias nobis laborum soluta! Facilis optio obcaecati quis dolores, aperiam consectetur similique quidem possimus."},
              # {title:"Repair an Electric Guitar",subtitle:"Repairing Solid Body Electric Guitars", full_description:"Lorem ipsum dolor sit amet, consectetur adipisicing elit. Ad eius, earum dolorum maiores corrupti veritatis cupiditate ut dolorem nostrum cumque doloremque necessitatibus, debitis iste accusantium quis molestiae, iusto modi alias."}]

# 10.times do |count|
#   user[:username] = "admin#{count}"
#   user[:email] = "admin#{count}@example.com"
#   User.create(user)
# end

# addresses = [{ address: "305 Stansted Manor",city: "Pflugerville" ,state: "TX", zip: 78660 },
#              { address: "1001 Mistyville Dr",city: "Austin" ,state: "TX", zip: 78810 },
#              { address: "123 Nice Street",city: "Round Rock" ,state: "TX", zip: 78660 }]

# addresses.each do |address|
  # Location.create(address)
# end

category_names.each do |category|
  Category.create(name: category, description:'')
end

# skills.each_with_index do |skill,i|
#   skill.merge!({:creator_id => User.find(i + 1).id, :skill_level_id => rand(1..5), location_id: Location.find(rand(1..addresses.count)).id, is_active: true })
#   skill = Skill.new(skill)
#   skill.categories << Category.find(rand(1..15))
#   skill.save!
# end


# skillrequest = {title: "Title", subtitle: "subtitle", full_description: "full description",:skill_level_id => rand(1..5), meeting_date_scheduled: nil, meeting_date_requested: DateTime.now + (rand(5).days), location_id: Location.find(rand(1..addresses.count)).id,has_apprenticeship: false}

# start = 1
# 5.times do |count|
#   title = skillrequest[:title] + "#{count}"
#   subtitle = skillrequest[:subtitle] + "#{count}"
#   user_id  = skillrequest[:user_id] = start
#   skillrequest.merge!({title: title, subtitle:subtitle, user_id: user_id})
#   newsr = SkillRequest.new(skillrequest)
#   newsr.categories << Category.find(rand(1..15))
#   newsr.save!
#   start += 1
# end
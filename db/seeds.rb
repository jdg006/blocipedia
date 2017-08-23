require 'faker'
5.times do
   User.create!(

   email:    Faker::Internet.unique.email,
   created_at: "2017-08-18 19:16:48" ,
   updated_at: "2017-08-18 19:16:48",
   password: Faker::Internet.password,
   role: 0
   
   )
 end
 users = User.all
 
 30.times do
     Wiki.create!(
        title: Faker::LordOfTheRings.location,
        body: Faker::ChuckNorris.fact,
        private: Faker::Boolean.boolean,
        
         )
  end
  
  wikis = Wiki.all
  
  10.times do
      Collaborator.create!(
          user: users.sample,
          wiki: wikis.sample
          )
  end
 
 puts "#{User.count} users created"
 puts "#{Wiki.count} Wikis created"
 puts "#{Collaborator.count} Collaborators created"

User.create!(name: "Akira Wakamatsu",
						user_name: "Akira",
						sex: "男",
						website: "https://www.instagram.com/",
						self_introduction: "よろしくお願いいたします。",
						phone: "090-1234-5678",
						admin: false,
						email: "example@gmail.com",
						password: "akira12345678"
	)
	
User.create!(name: "Naoko Sato",
						user_name: "Naoko",
						sex: "女",
						website: "https://www.instagram.com/",
						self_introduction: "よろしくお願いします！",
						phone: "080-8765-4321",
						admin: false,
						email: "example2@gmail.com",
						password: "naoko87654321"
	)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name,
  						 user_name: name,
               email: email,
               password: password
               )
end

users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content) }
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
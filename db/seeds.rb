User.create!(name: "Cao-Phuong-Anh", email: "thuanbk56@gmail.com",
  password: "pa0974340719", password_confirmation: "pa0974340719",
  admin: true)
99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(name: name, email: email, password: password,
    password_confirmation: password, admin: false)
end

User.create!(email: "thetoan@gmail.com", password: "12345678", admin: true)

10.times do |n|
  name = Faker::Lorem.word
  Category.create(name: name)
end

Category.all.each{|category|
  20.times do |n|
    content = Faker::Lorem.word
    question_type = 1;
    Question.create!(
      content: content,
      category_id: category.id,
      question_type: question_type)
  end
}

Question.all.each do |n|
  k = Random.rand(3) + 1
  4.times do |t|
    content = Faker::Lorem.word
    if t == k
      correct = true
    else
      correct = false
    end
    Answer.create(
      content: content,
      correct: correct,
      question_id: n.id)
  end
end

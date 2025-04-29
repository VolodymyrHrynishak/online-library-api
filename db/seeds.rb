5.times do
    user = User.create(name: Faker::Name.name, email: Faker::Internet.email)
    book = Book.create(title: Faker::Book.title, author: Faker::Book.author, description: Faker::Lorem.sentence)
    Comment.create(content: Faker::Lorem.paragraph, user: user, book: book)
  end
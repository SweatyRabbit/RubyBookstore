# frozen_string_literal: true

10.times { Author.create(first_name: FFaker::Name.first_name, last_name: FFaker::Name.last_name) }
10.times { Category.create(name: FFaker::Book.genre) }

50.times do
  book = Book.create(
    title: FFaker::Lorem.word,
    price: FFaker.numerify('##.##'),
    quantity: FFaker::Random.rand(5...100),
    description: FFaker::Book.description,
    publication_year: FFaker::Vehicle.year,
    height: FFaker.numerify('#.#'),
    width: FFaker.numerify('#.#'),
    depth: FFaker.numerify('#.#'),
    materials: FFaker::FreedomIpsum.word,
    category: Category.all.sample
  )
  book.authors << Author.all.sample(rand(1..3))
  book.title_image.attach(io: File.open('app/assets/images/default_book.png'),
                          filename: 'default_book.png', content_type: 'image/png')
  3.times do
    book.body_images.attach(io: File.open('app/assets/images/default_book.png'),
                            filename: 'default_book.png', content_type: 'image/png')
  end
end

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')

3.times do
  DeliveryType.create(
    name: FFaker::FreedomIpsum.word,
    min_days: FFaker::Random.rand(1...6),
    max_days: FFaker::Random.rand(7...15),
    price: FFaker.numerify('##.##')
  )
end

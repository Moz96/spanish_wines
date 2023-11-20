# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts 'Seeding users...'
User.create(email: 'user1@example.com', password: 'password123')
User.create(email: 'user2@example.com', password: 'password456')
# Add more users as needed...

puts 'Seeding products...'
Product.create(name: 'Product 1', description: 'Description for Product 1', price: 19.99, vintage: 2022, quantity: 10, category: "red")
Product.create(name: 'Product 2', description: 'Description for Product 2', price: 29.99, vintage: 2021, quantity: 5, category: "white")
Product.create(name: 'Product 3', description: 'Description for Product 3', price: 19.99, vintage: 2022, quantity: 10, category: "red")
Product.create(name: 'Product 4', description: 'Description for Product 4', price: 29.99, vintage: 2021, quantity: 5, category: "white")
# Add more products as needed...

puts 'Seeding addresses...'
Address.create(user_id: 1, address_line: '123 Street', city: 'City', county: 'County', post_code: '12345')
Address.create(user_id: 2, address_line: '456 Street', city: 'City', county: 'County', post_code: '67890')
# Add more addresses as needed...

puts 'Seeding orders...'
Order.create(total_price: 39.99, user_id: 1, product_id: 1)
Order.create(total_price: 59.99, user_id: 2, product_id: 2)
# Add more orders as needed...

puts 'Seeding payments...'
Payment.create(order_id: 1, transaction_id: 'ABC123', amount: 39.99, payment_method: 'Credit Card')
Payment.create(order_id: 2, transaction_id: 'DEF456', amount: 59.99, payment_method: 'PayPal')
# Add more payments as needed...

puts 'Seeding reviews...'
Review.create(user_id: 1, product_id: 1, rating: 5, description: 'Great product!')
Review.create(user_id: 2, product_id: 2, rating: 4, description: 'Nice item.')
# Add more reviews as needed...

puts 'Seeding completed!'

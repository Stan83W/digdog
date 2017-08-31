# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Finding.destroy_all


markets = ["Amazon", "LeBoncoin", "PriceMinister", "Ebay"]
currency = ["$", "£", "€"]
location = ["France", "Japan", "UK", "Spain", "USA"]

30.times do
  find_1 = Finding.create(
  provider: markets.sample, 
  currency: currency.sample, 
  url: "", 
  price: rand(10..100), 
  thumb: "", 
  title: "Untitled", 
  location: location.sample, 
  record_id: Record.order("RANDOM()").first.id
  )
end

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Finding.destroy_all


markets = ["Amazon", "Le bon coin", "PriceMinister", "Ebay"]
currency = ["$", "£", "€"]
location = ["France", "Japan", "UK", "Spain", "USA"]
find_1 = Finding.new(
  provider: markets.sample,
  currency: currency.sample,
  location: location.sample,
  record_id: Record.order("RANDOM()").first.id,
  )
if find_1.valid?
  find_1.save
end
find_2 = Finding.new(
  provider: markets.sample,
  currency: currency.sample,
  location: location.sample,
  record_id: Record.order("RANDOM()").first.id,
  )
if find_2.valid?
  find_2.save
end
find_3 = Finding.new(
  provider: markets.sample,
  currency: currency.sample,
  location: location.sample,
  record_id: Record.order("RANDOM()").first.id,
  )
if find_3.valid?
  find_3.save
end
find_4 = Finding.new(
  provider: markets.sample,
  currency: currency.sample,
  location: location.sample,
  record_id: Record.order("RANDOM()").first.id,
  )
if find_4.valid?
  find_4.save
end
find_5 = Finding.new(
  provider: markets.sample,
  currency: currency.sample,
  location: location.sample,
  record_id: Record.order("RANDOM()").first.id,
  )
if find_5.valid?
  find_5.save
end
find_6 = Finding.new(
  provider: markets.sample,
  currency: currency.sample,
  location: location.sample,
  record_id: Record.order("RANDOM()").first.id,
  )
if find_6.valid?
  find_6.save
end

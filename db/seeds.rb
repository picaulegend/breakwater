thomas = User.create!(
  email: "picauly88@gmail.com",
  first_name: "Thomas",
  last_name: "Picauly",
  money: 25,
  days_played: 0,
)

Farm.create!(
  [{
    name: "FUNKY FARM",
    user: thomas,
  }]
)

store = Store.create!(
  name: "Breakwater Store",
  user: thomas,
)

# thomas = User.find("1")
# store = Store.find("1")
# seed = Seed.find("1")

seed = Seed.create!(
  name: "Blueberry",
  produce_type: "BERRIES",
  longevity: 3,
  health: 5,
  nutrition: 9,
  days_required: 12,
  value: 40,
)

Item.create!(
  amount_in_stock: 30,
  price: 40,
  store: store,
  seed: seed,
)

# Seed.create!([{
#   name: "Blueberry",
#   produce_type: "BERRIES",
#   longevity: 3,
#   health: 5,
#   nutrition: 9,
#   days_required: 12,
#   value: 40,
# }, {
#   name: "Grape",
#   produce_type: "BERRIES",
#   longevity: 3,
#   health: 5,
#   nutrition: 9,
#   days_required: 12,
#   value: 20,
# }])

Product.create!([{
  name: "Strawberry",
  value: 30,
  produce_type: "BERRIES",
  longevity: 3,
  health: 5,
  nutrition: 9,
  size: 30,
  user: thomas,
},
                 {
  name: "Cherry",
  value: 30,
  produce_type: "BERRIES",
  longevity: 3,
  health: 5,
  nutrition: 9,
  size: 30,
  user: thomas,
},
                 {
  name: "Avocado",
  value: 30,
  produce_type: "BERRIES",
  longevity: 3,
  health: 5,
  nutrition: 9,
  size: 30,
  user: thomas,
}])

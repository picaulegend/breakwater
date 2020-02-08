# thomas = User.create!(
#   email: "picauly88@gmail.com",
#   first_name: "Thomas",
#   last_name: "Picauly",
# )

# Farm.create!(
#   [{
#     name: "FUNKY FARM",
#     user: thomas,
#   }]
# )

thomas = User.find("1")
store = Store.find("2")

Seed.create!([{
  name: "Woodberry",
  produce_type: "BERRIES",
  longevity: 3,
  health: 5,
  nutrition: 9,
  days_required: 12,
  value: 40,
  store: store,
}, {
  name: "Juico",
  produce_type: "BERRIES",
  longevity: 3,
  health: 5,
  nutrition: 9,
  days_required: 12,
  value: 20,
  store: store,
}])

# Product.create!([{
#   name: "Strawberry",
#   value: 30,
#   produce_type: "BERRIES",
#   longevity: 3,
#   health: 5,
#   nutrition: 9,
#   size: 30,
#   user: thomas,
# },
#                  {
#   name: "Cherry",
#   value: 30,
#   produce_type: "BERRIES",
#   longevity: 3,
#   health: 5,
#   nutrition: 9,
#   size: 30,
#   user: thomas,
# },
#                  {
#   name: "Avocado",
#   value: 30,
#   produce_type: "BERRIES",
#   longevity: 3,
#   health: 5,
#   nutrition: 9,
#   size: 30,
#   user: thomas,
# }])

# Store.create!(
#   name: "Breakwater Store",
#   user: thomas,
# )

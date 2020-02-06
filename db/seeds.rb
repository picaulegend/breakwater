# john = User.create!(
#   email: "john.doe@example.com",
#   first_name: "John",
#   last_name: "Doe",
# )

# jane = User.create!(
#   email: "jane.doe@example.com",
#   first_name: "Jane",
#   last_name: "Doe",
# )

# Farm.create!(
#   [{
#     name: "FUNKY FARM",
#     user: john,
#   }]
# )

user = User.find("1")
# slot = Slot.find("1")

Seed.create!([{
  name: "Raspberry",
  produce_type: "BERRIES",
  longevity: 3,
  health: 5,
  nutrition: 9,
  days_required: 12,
  user: user,
}])

# Product.create!([{
#   name: "Strawberry",
#   value: 30,
#   user: user,
# }])

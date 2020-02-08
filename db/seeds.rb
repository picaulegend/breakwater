thomas = User.create!(
  email: "picauly88@gmail.com",
  first_name: "Thomas",
  last_name: "Picauly",
  days_played: 0,
  money: 0,
)

Farm.create!(
  [{
    name: "FUNKY FARM",
    user: thomas,
  }]
)

Seed.create!([{
  name: "Raspberry",
  produce_type: "BERRIES",
  longevity: 3,
  health: 5,
  nutrition: 9,
  days_required: 12,
  user: thomas,
}, {
  name: "Grape",
  produce_type: "BERRIES",
  longevity: 3,
  health: 5,
  nutrition: 9,
  days_required: 12,
  user: thomas,
}])

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

Package.destroy_all

Package.create!([
  {
    name: "The Marais at Noon",
    slug: "marais-at-noon",
    tagline: "3 hours · $500 per tour",
    description: "The old Jewish quarter before the tourists figure out where the good falafel is. We walk slowly.",
    price_cents: 50000,
    duration: "3 hours",
    stripe_price_id: "price_1TD14HCS2yvuIpYkKqfNbPTf"
  },
  {
    name: "A Full Day, Properly",
    slug: "full-day",
    tagline: "8 hours · $1,500 per tour",
    description: "Markets in the morning, a long lunch somewhere you would never find on your own, two galleries in the afternoon. No rushing.",
    price_cents: 150000,
    duration: "8 hours",
    stripe_price_id: "price_1TD14uCS2yvuIpYk8AlDDHXj"
  },
  {
    name: "Evening, No Plan",
    slug: "evening",
    tagline: "3 hours · $1,000 per tour",
    description: "We start at a wine bar in the 11th and see where it goes. Always ends well.",
    price_cents: 100000,
    duration: "3 hours",
    stripe_price_id: "price_1TD15dCS2yvuIpYkVFuqLd2k"
  }
])

puts "Seeded #{Package.count} packages."

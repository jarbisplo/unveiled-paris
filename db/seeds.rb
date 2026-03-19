Package.destroy_all

Package.create!([
  {
    name: "The Marais at Noon",
    slug: "marais-at-noon",
    tagline: "3 hours · $149 per person",
    description: "The old Jewish quarter before the tourists figure out where the good falafel is. We walk slowly.",
    price_cents: 14900,
    duration: "3 hours",
    stripe_price_id: ""
  },
  {
    name: "A Full Day, Properly",
    slug: "full-day",
    tagline: "8 hours · $349 per person",
    description: "Markets in the morning, a long lunch somewhere you would never find on your own, two galleries in the afternoon. No rushing.",
    price_cents: 34900,
    duration: "8 hours",
    stripe_price_id: ""
  },
  {
    name: "Evening, No Plan",
    slug: "evening",
    tagline: "4 hours · $249 per person",
    description: "We start at a wine bar in the 11th and see where it goes. Always ends well.",
    price_cents: 24900,
    duration: "4 hours",
    stripe_price_id: ""
  }
])

puts "Seeded #{Package.count} packages."

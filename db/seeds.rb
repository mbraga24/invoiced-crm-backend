Contact.destroy_all

contacts = [
  { id: 1, firstName: 'Andrew', lastName: 'Cataluna',  email: 'andrew@example.com' },
  { id: 2, firstName: 'Mark', lastName: 'Koslo', email: 'mark@example.com' },
  { id: 3, firstName: 'Sarah', lastName: 'Tompson', email: 'sarah@example.com' }
]

contacts.each do |contact|
  Contact.create(
    first_name: contact[:firstName],
    last_name: contact[:lastName],
    email: contact[:email],
  )
end

puts "========================="
puts "         SEEDED"
puts "========================="
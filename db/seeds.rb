
puts "Cleaning database..."
Message.destroy_all
User.destroy_all

puts "Creating users..."
alice = User.create!(
  email: "alice@example.com",
  password: "password123",
  password_confirmation: "password123"
)

bob = User.create!(
  email: "bob@example.com",
  password: "password123",
  password_confirmation: "password123"
)

carlos = User.create!(
  email: "carlos@example.com",
  password: "password123",
  password_confirmation: "password123"
)

puts "Creating messages..."

Message.create!(
  content: "Olá Bob, como vai?",
  sender: alice,
  recipient: bob,
  created_at: 2.days.ago
)

Message.create!(
  content: "Oi Alice! Estou bem, e você?",
  sender: bob,
  recipient: alice,
  created_at: 2.days.ago + 10.minutes
)

Message.create!(
  content: "Estou ótima! Você viu o novo projeto que precisamos entregar?",
  sender: alice,
  recipient: bob,
  created_at: 2.days.ago + 15.minutes
)

Message.create!(
  content: "Sim, estou trabalhando nele agora. Podemos conversar sobre isso amanhã.",
  sender: bob,
  recipient: alice,
  created_at: 2.days.ago + 20.minutes
)

Message.create!(
  content: "Oi Carlos, você tem um minuto?",
  sender: alice,
  recipient: carlos,
  created_at: 1.day.ago
)

Message.create!(
  content: "Claro Alice, como posso ajudar?",
  sender: carlos,
  recipient: alice,
  created_at: 1.day.ago + 5.minutes
)

Message.create!(
  content: "Preciso da sua ajuda com o relatório mensal.",
  sender: alice,
  recipient: carlos,
  created_at: 1.day.ago + 10.minutes
)

Message.create!(
  content: "Sem problema! Posso te ajudar com isso amanhã pela manhã.",
  sender: carlos,
  recipient: alice,
  created_at: 1.day.ago + 15.minutes
)

# Conversa entre Bob e Carlos
Message.create!(
  content: "E aí Carlos, tudo bem?",
  sender: bob,
  recipient: carlos,
  created_at: 12.hours.ago
)

Message.create!(
  content: "Tudo ótimo Bob, e com você?",
  sender: carlos,
  recipient: bob,
  created_at: 12.hours.ago + 8.minutes
)

Message.create!(
  content: "Estou bem! Vamos marcar aquele café esta semana?",
  sender: bob,
  recipient: carlos,
  created_at: 12.hours.ago + 15.minutes
)

Message.create!(
  content: "Claro! Que tal na quinta-feira?",
  sender: carlos,
  recipient: bob,
  created_at: 12.hours.ago + 25.minutes
)

puts "Seeds completed! Created:"
puts "- #{User.count} users"
puts "- #{Message.count} messages"
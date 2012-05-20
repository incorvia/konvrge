Factory.define :user do |u|
  u._id         '4f072f55c2c2e50cff0008a9'
  u.first_name  'Kevin'
  u.last_name   'Incorvia'
  u.username    'incorvia'
  u.name        'Kevin Incorvia'
  u.fb_id       '751080764'
  u.email       'incorvia@gmail.com'
  u.token       'ABCDEFG'
  u.password    'password'
  u.password_confirmation 'password'
end

Factory.define :event do |e|
  e.user_id     '4f072f55c2c2e50cff0008a9'
  e.user_name   'Kevin Incorvia'
  e.title       'Konvrge wins best website award'
  e.location    'Mountain View, CA'
  e.category    'Technology'
  e.questions    { [Factory.build(:question)] }
  e.vote_count  0
  e.score       0
  e.created_at  Time.now
end

Factory.define :question do |q|
  q.title   "Is Kermit the frog really green?"
  q.user_id "4f072f55c2c2e50cff0008a9"
end

Factory.define :friend do |f|
  f.name  "John Doe"
  f.fb_id  "15231521"
end

# Sequences
Factory.sequence :full_name do |n|
  names = ["Michael Jordan", "Tiger Woods", "Barack Obama", "Clint Eastwood", "Scarlett O'Hara",
          "Yogi Berra", "Michael Phelps", "Bill Buckner", "Casey Lala", "Sally Rider", "Mickey Mouse",
          "Jerry Seinfield", "Elaine Bettis", "George Costanza"]
  names[n]
end

Factory.sequence :created_at do |n|
  Time.now - (2 * n).hours
end

Factory.sequence :fb_id do |n|
  rand(1000000..9999999).to_s
end
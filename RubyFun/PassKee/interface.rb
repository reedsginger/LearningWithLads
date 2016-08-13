puts 'Please enter a username!'
username = gets.chomp
puts 'Please enter a password!'
password = gets.chomp

puts "The username you have entered is #{username}. The password you have entered is #{password}."

master = open('data/master.txt', 'w')
creds = "#{username}:#{password}"
master.write(creds)
master.close

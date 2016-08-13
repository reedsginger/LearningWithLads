#May want to switch to YAML files for the sorage of data
def auth
  if File.zero?('data/master.txt')
    puts 'Please enter a username!'
    username = gets.chomp
    puts 'Please enter a password!'
    password = gets.chomp

    puts "The username you have entered is #{username}. The password you have entered is #{password}."

    master = open('data/master.txt', 'w')
    creds = "#{username}:#{password}"
    master.write(creds)
    master.close
    return true
  end

  puts 'Please enter your master username!'
  username = gets.chomp
  puts 'Please enter your master password!'
  password = gets.chomp

  data = open('data/master.txt', 'r')
  master_user, master_pass = data.read.split(':')
  master_user == username && master_pass == password
end

def app
  if auth
    puts 'Welcome!'
  end
end

app

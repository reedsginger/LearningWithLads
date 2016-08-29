require "yaml"
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

def infoRetreive
  account = YAML.load_file('data/accountInformation.yml')
  puts "Please select an service you would like information for!"
  service = gets.chomp
  puts "The username is #{account['accounts']["#{service}"][0]}"
  puts "The password is #{account['accounts']["#{service}"][1]}"
end


def app
  puts auth ? "Welcome!" :  "That is an incorrenct login!"

  puts "To retreive account information please type \"retreive\""
  command = gets.chomp
  if command == 'retreive'; infoRetreive
  elsif command == 'help'; puts "The only command wired right now is retreive."
  else; puts 'not a valid command'
  end

end

app

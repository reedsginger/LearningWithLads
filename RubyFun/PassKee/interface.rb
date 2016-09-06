require "yaml"
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

  if !account.key?("#{service}")
    puts "You have not information for that service."
    menu
  end

  keys = []
  account["#{service}"].map{|user,pass| keys << user}



  if keys.size == 0
    puts "There is no information for that service."
  elsif keys.size > 1
    keys.map{|user| puts "#{user}"}
    puts "Please choose the username for the information you would like."
    username = gets.chomp
    puts "The username is #{username}."
    puts "The password is #{account["#{service}"]["#{username}"]}."
  else
    puts "The username is #{keys[0]}."
    puts "The password is #{account["#{service}"]["#{keys[0]}"]}."
  end
  menu
end

def infoAdd
  account = YAML.load_file('data/accountInformation.yml')
  puts "What service would you like to add to?"
  service = gets.chomp

  if account.key?("#{service}")
    puts "Please enter username."
    username = gets.chomp
    puts "Please enter password."
    password = gets.chomp

    if !account["#{service}"].key?("#{username}")
      account["#{service}"]["#{username}"] = password
      File.open('data/accountInformation.yml', 'w') {|f| f.write account.to_yaml}
      puts "The information has been added."
    else
      puts "Information for that account already exists."
    end
  else
    puts "Please enter username."
    username = gets.chomp
    puts "Please enter password."
    password = gets.chomp

    account["#{service}"] = {}
    account["#{service}"]["#{username}"] = password

    File.open('data/accountInformation.yml', 'w') {|f| f.write account.to_yaml}
  end
  menu
end

def menu
  puts "To retreive account information please type \"retreive\" or \"r\""
  puts "To add new account information please type \"add\" or \"a\""
  command = gets.chomp

  if command == 'retreive' || command == 'r'
    infoRetreive
  elsif command == 'add' || command == 'a'
    infoAdd
  elsif command == 'help'
    puts "The only command wired right now is retreive."
    menu
  else
    puts 'not a valid command'
    menu
  end
end

def login
  if auth
    "Welcome!"
    menu
  else
    "That is an incorrenct login!"
  end
end

login

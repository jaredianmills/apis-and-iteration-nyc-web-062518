def welcome
  puts "Welcome!"
end

def get_character_from_user
  puts "please enter a character and I'll tell you what movies they were in:"
  character = gets.strip
  character.downcase
end

require_relative "prime"

(1..500000).each do |number|
  puts number if prime?(number)
end

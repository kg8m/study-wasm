def prime?(number)
  return false if number <= 1
  return true if number == 2
  return false if number % 2 == 0

  3.step(by: 2, to: Math.sqrt(number).floor) do |i|
    if number % i == 0
      return false
    end
  end

  true
end

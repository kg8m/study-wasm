require "minitest/autorun"
require_relative "prime"
require "prime"

class PrimeTest < MiniTest::Test
  def test_same_as_prime_prime
    (1..500000).each do |number|
      testcase = "number: #{number}"
      assert_equal Prime.prime?(number), prime?(number), testcase
    end
  end
end

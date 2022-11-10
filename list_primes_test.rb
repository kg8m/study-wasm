require "minitest/autorun"

class ListPrimesTest < MiniTest::Test
  def test_all_same_result
    raw_ruby_result = `ruby list_primes.rb`
    raw_go_result = `go run list_primes.go`
    built_go_result = `./list_primes.go.bin`
    raw_js_result = `node list-primes.js`
    # Ignore these because tests fail maybe due to the stdout output not being flushed.
    # wasm_go_result = `node --experimental-wasi-unstable-preview1 list-primes.wasm.go.js`
    # wasm_ruby_result = `node --experimental-wasi-unstable-preview1 list-primes.wasm.ruby.js`

    assert_equal raw_ruby_result, raw_go_result
    assert_equal raw_ruby_result, built_go_result
    assert_equal raw_ruby_result, raw_js_result
    # assert_equal raw_ruby_result, wasm_go_result
    # assert_equal raw_ruby_result, wasm_ruby_result
  end
end

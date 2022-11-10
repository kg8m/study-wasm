.DEFAULT_GOAL := help

HELP_SEPARATOR := ＠

SRC_FILENAME_GO        := list_primes.go
SRC_FILENAME_JS        := list-primes.js
SRC_FILENAME_RUBY      := list_primes.rb
SRC_FILENAME_WASM_GO   := list-primes.wasm.go.js
SRC_FILENAME_WASM_RUBY := list-primes.wasm.ruby.js

BIN_FILENAME_GO := ${SRC_FILENAME_GO}.bin

WASM_FILENAME_GO := ${SRC_FILENAME_GO}.wasm

.PHONY: help
help:  ## Show help
	@cat $(MAKEFILE_LIST) | \
		grep -E '^[-a-z]+:' | \
		sed -e 's/:.*## /$(HELP_SEPARATOR)/' | \
		column -t -s $(HELP_SEPARATOR)

.PHONY: benchmark
benchmark:  ## Execute benchmark
	hyperfine --warmup 1 \
		'node --experimental-wasi-unstable-preview1 ${SRC_FILENAME_WASM_RUBY}' \
		'node --experimental-wasi-unstable-preview1 ${SRC_FILENAME_WASM_GO}' \
		'node --experimental-wasi-unstable-preview1 ${SRC_FILENAME_JS}' \
		'ruby ${SRC_FILENAME_RUBY}' \
		'go run ${SRC_FILENAME_GO}' \
		'./${BIN_FILENAME_GO}'

build: ${BIN_FILENAME_GO} ${WASM_FILENAME_GO}  ## Build executables and WASM files

${BIN_FILENAME_GO}: ${SRC_FILENAME_GO}
	go build -o ${BIN_FILENAME_GO} ./${SRC_FILENAME_GO}

${WASM_FILENAME_GO}: ${SRC_FILENAME_GO}
	GOOS=js GOARCH=wasm go build -o ${WASM_FILENAME_GO} ./${SRC_FILENAME_GO}

.PHONY: clean
clean:  ## Remove built artifacts
	rm -f ${BIN_FILENAME_GO} ${WASM_FILENAME_GO}

.PHONY: test
test:  ## Execute tests
	ruby prime_test.rb
	ruby list_primes_test.rb

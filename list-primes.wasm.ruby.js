// https://github.com/ruby/ruby.wasm
import fs from "fs/promises";
import { DefaultRubyVM } from "ruby-head-wasm-wasi/dist/node.cjs.js";

const main = async () => {
  const binary = await fs.readFile(
    //  Tips: Replace the binary with debug info if you want symbolicated stack trace.
    //  (only nightly release for now)
    //  "./node_modules/ruby-head-wasm-wasi/dist/ruby.debug+stdlib.wasm"
    "./node_modules/ruby-head-wasm-wasi/dist/ruby.wasm"
  );
  const module = await WebAssembly.compile(binary);
  const { vm } = await DefaultRubyVM(module);

  vm.eval(`
    ${await fs.readFile("./prime.rb")}

    (1..500000).each do |number|
      puts number if prime?(number)
    end
  `);
};

main();

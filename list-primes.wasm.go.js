// https://blog.devgenius.io/node-js-in-go-we-trust-7da6395776f2
// $ ln -s $(go env GOROOT)/misc/wasm/wasm_exec.js ./
import "./wasm_exec.js";
import fs from "fs";

const main = async () => {
  const go = new global.Go();
  const wasmBuffer = fs.readFileSync("./list_primes.go.wasm");
  const wasmModule = await WebAssembly.instantiate(wasmBuffer, go.importObject);
  go.run(wasmModule.instance);
};

main();

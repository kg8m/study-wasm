function isPrime(number) {
  if (number <= 1) {
    return false;
  } else if (number === 2) {
    return true;
  } else if (number % 2 === 0) {
    return false;
  }

  const loopLimit = Math.floor(Math.sqrt(number));

  for (let i = 3; i <= loopLimit; i = i + 2) {
    if (number % i === 0) {
      return false;
    }
  }

  return true;
}

const main = () => {
  for (let number = 1; number <= 500000; number++) {
    if (isPrime(number)) {
      console.log(number);
    }
  }
};

main();

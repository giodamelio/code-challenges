(function(exports){
    // Get all the fibonacci less then n
    exports.fib = function(n) {
        var fibSequence = [];
        var recursiveFinder = function (a, b) {
            fibSequence.push(a);
            if (b < n) {
                recursiveFinder(b, a + b);
            }
        };
        recursiveFinder(0, 1);
        return fibSequence;
    };

    // Get all of a numbers prime factors
    exports.getPrimeFactors = function(n) {
        var root = Math.sqrt(n);
        // Get unnamed argument from recursive calls
        var result = arguments[1] || [];
        var x = 2; 

        if(n % x){ 
            x = 3;
            while((n % x) && ((x = x + 2) < root)){}
        }
        x = (x <= root) ? x: n;
        result.push(x);
        return (x === n) ? result: exports.getPrimeFactors(n/x, result);
    };

    // Determine if a number is palindromic
    exports.isPalindromic = function(n) {
        // Convert our number to string
        var str = n.toString();

        // Loop through our string comparing the first and last characters, then the second and second to last and so on
        var a = str.length - 1;
        var b = 0;
        while (a > b) {
            if (str.charAt(b++) !== str.charAt(a--)) {
                return false;
            }
        }
        return true;
    };

    // Find the greatest common divisor of two numbers
    exports.greatestCommenDivisor = function(a, b) {
        if (b) {
            return exports.greatestCommenDivisor(b, a % b);
        } else {
            return Math.abs(a);
        }
    };

    // Find the least common multible of two numbers
    exports.leastCommonMultiple = function(a, b) {
        return (a * b) / exports.greatestCommenDivisor(a, b);
    };

    // Create an array of numbers, similar to pythons range()
    exports.range = function(start, stop, step){
        if (typeof stop === "undefined"){
            // one param defined
            stop = start;
            start = 0;
        }
        if (typeof step === "undefined"){
            step = 1;
        }
        if ((step > 0 && start >= stop) || (step < 0 && start <= stop)){
            return [];
        }
        var result = [];
        for (var i = start; step > 0 ? i < stop: i > stop; i += step){
            result.push(i);
        }
        return result;
    };

    // Test to see if a number is prime
    exports.isPrime = function(n) {
        var sqrtN = Math.sqrt(n);
        for (var i = 2; i <= sqrtN; i++) {
            if (n % i === 0) {
                return false;
            }
        }
        return true;
    };

    // Get first n primes
    exports.firstNPrimes = function(n) {
        var primes = [];
        var a = 2;
        while (primes.length < n) {
            if (exports.isPrime(a)) {
                primes.push(a);
            }
            a++;
        }
        return primes;
    };

    // Test to see if three numbers are a Pythagorean triplet
    exports.isPythagoreanTriplet = function(a, b, c) {
        return (a * a) + (b * b) === (c * c);
    };
})(typeof exports === "undefined"? this.mathlib={}: exports);

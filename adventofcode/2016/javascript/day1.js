// --- Day 1: No Time for a Taxicab ---

// Santa's sleigh uses a very high-precision clock to guide its movements, and the clock's oscillator is regulated by stars. Unfortunately, the stars have been stolen... by the Easter Bunny. To save Christmas, Santa needs you to retrieve all fifty stars by December 25th.

// Collect stars by solving puzzles. Two puzzles will be made available on each day in the advent calendar; the second puzzle is unlocked when you complete the first. Each puzzle grants one star. Good luck!

// You're airdropped near Easter Bunny Headquarters in a city somewhere. "Near", unfortunately, is as close as you can get - the instructions on the Easter Bunny Recruiting Document the Elves intercepted start here, and nobody had time to work them out further.

// The Document indicates that you should start at the given coordinates (where you just landed) and face North. Then, follow the provided sequence: either turn left (L) or right (R) 90 degrees, then walk forward the given number of blocks, ending at a new intersection.

// There's no time to follow such ridiculous instructions on foot, though, so you take a moment and work out the destination. Given that you can only walk on the street grid of the city, how far is the shortest path to the destination?

// For example:

// Following R2, L3 leaves you 2 blocks East and 3 blocks North, or 5 blocks away.
// R2, R2, R2 leaves you 2 blocks due South of your starting position, which is 2 blocks away.
// R5, L5, R5, R3 leaves you 12 blocks away.
// How many blocks away is Easter Bunny HQ?

const input = 'R4, R4, L1, R3, L5, R2, R5, R1, L4, R3, L5, R2, L3, L4, L3, R1, R5, R1, L3, L1, R3, L1, R2, R2, L2, R5, L3, L4, R4, R4, R2, L4, L1, R5, L1, L4, R4, L1, R1, L2, R5, L2, L3, R2, R1, L194, R2, L4, R49, R1, R3, L5, L4, L1, R4, R2, R1, L5, R3, L5, L4, R4, R4, L2, L3, R78, L5, R4, R191, R4, R3, R1, L2, R1, R3, L1, R3, R4, R2, L2, R1, R4, L5, R2, L2, L4, L2, R1, R2, L3, R5, R2, L3, L3, R3, L1, L1, R5, L4, L4, L2, R5, R1, R4, L3, L5, L4, R5, L4, R5, R4, L3, L2, L5, R4, R3, L3, R1, L5, R5, R1, L3, R2, L5, R5, L3, R1, R4, L5, R4, R2, R3, L4, L5, R3, R4, L5, L5, R4, L4, L4, R1, R5, R3, L1, L4, L3, L4, R1, L5, L1, R2, R2, R4, R4, L5, R4, R1, L1, L1, L3, L5, L2, R4, L3, L5, L4, L1, R3';

// Directions
//  0
// 3 1
//  2

// Create a object of the distances traveled in each direction
function distanceTraveled(str) {
  return str
    .split(', ')
    // Split direction and distance
    .map(input => [input[0], parseInt(input.slice(1))])

    // Convert to an object of directions and the distance each direction has been traveled
    .reduce((acc, [direction, distance]) => {
        // Change the direction using modulo to wrap around
        acc.facing = (direction === 'R') ? (acc.facing + 1) % 4 : (acc.facing + 3) % 4;
        acc[acc.facing] += distance;

        // Add every point between the current one and the next one to the path
        acc.path.push([acc[1] - acc[3], acc[0] - acc[2]]);
        return acc; 
    }, {
        facing: 0, // Start facing north
        path: [], // The path we took
        0: 0, // North
        1: 0, // East
        2: 0, // South
        3: 0, // West
    });
}

// Calculate the manhatten distance between two points
function manhattenDistance(a, b) {
  return Math.abs(a[0] - b[0]) + Math.abs(a[1], b[1]);
}

// Convert the individual distances to absolute distances in the x and y axies and calculate distance from start
function calculateDistance(distances) {
  const lastLocation = distances.path.pop();

  return {
    total: manhattenDistance(lastLocation, [0, 0]),
    x: lastLocation[0],
    y: lastLocation[1],
  }
}

// Find the first point visited twice in an array of [x, y] arrays
function firstDuplicate(path) {
  const map = {};
  for (let i in path) {
    if (map[path[i]]) {
      console.log(path[i], map);
      return path[i];
    }
    map[path[i]] = true;
  }
  console.log(map);
  return [0, 0];
}

const traveled = distanceTraveled('R8, R4, R4, R8');
const lastLocation = traveled.path[traveled.path.length - 1];
const distance = manhattenDistance(lastLocation, [0, 0]);
const dup = firstDuplicate(traveled.path);
console.log(dup);
const easterBunnyHQ = manhattenDistance(dup, lastLocation);
console.log(easterBunnyHQ);

// Print the data all pretty like
console.log(`You are ${distance} blocks away from your starting point`);

if (lastLocation[1] > 0) {
  console.log(`You are ${Math.abs(lastLocation[1])} blocks north of the starting point`);
} else if (lastLocation[1] < 0) {
  console.log(`You are ${Math.abs(lastLocation[1])} blocks south of the starting point`);
} else {
  console.log(`You are at the same latitude as the starting point`);
}

if (lastLocation[0] > 0) {
  console.log(`You are ${Math.abs(lastLocation[0])} blocks east of the starting point`);
} else if (lastLocation[0] < 0) {
  console.log(`You are ${Math.abs(lastLocation[0])} blocks west of the starting point`);
} else {
  console.log(`You are at the same longitude as the starting point`);
}

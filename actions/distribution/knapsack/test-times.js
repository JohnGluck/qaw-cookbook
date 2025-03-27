const fs = require('fs');
const testDataPath = process.argv[2] || 'test-times.json';
const numShards = parseInt(process.argv[3]) || 4;
const testTimes = JSON.parse(fs.readFileSync(testDataPath, 'utf8'));
const sortedTests = testTimes.sort((a, b) => b.time - a.time); // Sort tests by execution time
const shards = Array.from({ length: numShards }, () => ({ tests: [], totalTime: 0 }));
for (const test of sortedTests) {
  const lightestShard = shards.reduce((min, curr) => (curr.totalTime < min.totalTime ? curr : min));
  lightestShard.tests.push(test.test);
  lightestShard.totalTime += test.time;
}

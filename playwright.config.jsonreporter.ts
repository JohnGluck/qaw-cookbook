import { defineConfig } from '@playwright/test';

export default defineConfig({
  reporter: [
    ['json', { outputFile: 'test-results/results.json' }]
  ],
  use: {
    trace: 'on-first-retry'
  }
});

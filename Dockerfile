FROM mcr.microsoft.com/playwright:v1.51.1-jammy

# Set working directory
WORKDIR /app

# Copy only what's needed to install dependencies
COPY package.json package-lock.json ./
RUN npm ci

# Copy only the files required to run tests
COPY playwright.config.ts ./
COPY tests ./tests

# Set default command (optional)
CMD ["npx", "playwright", "test"]

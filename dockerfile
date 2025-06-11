    # Use official Node image as base
FROM node:16

WORKDIR /app

# Copy package files and install dependencies first (for caching)
COPY package*.json ./
RUN npm install

# Copy env file
COPY .env.production .env

# Copy rest of the app
COPY . .

# Build the app
RUN npm run build

# Start command
CMD ["npm", "start"]

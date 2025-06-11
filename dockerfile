# Stage 1: Build React app
FROM node:16 AS build

WORKDIR /app

# Copy package files and install dependencies
COPY package*.json ./
RUN npm install

# Copy all source files
COPY . .

# Pass API key as build arg and inject into environment variable for React build
ARG TMDB_V3_API_KEY
ENV REACT_APP_TMDB_V3_API_KEY=$TMDB_V3_API_KEY

# Build the React app for production
RUN npm run build

# Stage 2: Serve app with nginx
FROM nginx:alpine

# Copy built files from the build stage
COPY --from=build /app/build /usr/share/nginx/html

# Copy custom nginx config if you have one (optional)
# COPY nginx.conf /etc/nginx/nginx.conf

# Expose port 80
EXPOSE 80

# Start nginx server
CMD ["nginx", "-g", "daemon off;"]

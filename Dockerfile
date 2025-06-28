# Step 1: Build React app
FROM node:18-alpine AS builder

WORKDIR /app

# Install dependencies
COPY package.json package-lock.json ./
RUN npm install

# Copy app source code
COPY . .

# Build optimized production version
RUN npm run build


# Step 2: Serve app with Nginx
FROM nginx:alpine

# Copy build output to Nginx html directory
COPY --from=builder /app/build /usr/share/nginx/html

# Expose port 80 good
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]

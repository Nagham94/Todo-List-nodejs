# Use lightweight Node.js image
FROM node:lts-alpine3.22

# Set working directory
WORKDIR /usr/app

# Copy and install dependencies
COPY package*.json ./
RUN npm install

# Copy application source
COPY . .

# Expose the port your app runs on
EXPOSE 4000

# Start the app
CMD [ "npm", "start" ]

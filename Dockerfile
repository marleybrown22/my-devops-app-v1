# 1. Builder Stage

FROM node:26.1.0-alpine3.22 AS builder

# We use alpine because it is leaner and smaller. 
# It does not require large memory to run our application image. 
# This is also best practice to avoid vulnerabilities with larger distributions.

WORKDIR /app

# Copy only package files first for caching
COPY package*.json ./

# Install ONLY production dependencies
#RUN npm install
RUN npm ci --only=production

# Copy the rest of the application
COPY . .

# 2. Production Stage
# we use node alpine because it is a smaller image
FROM node:26.1.0-alpine3.22 AS production

WORKDIR /app

# Create non-root user
# this is for better securtity purpose
RUN addgroup -S appgroup && adduser -S appuser -G appgroup

# Copy built app from builder
COPY --from=builder /app /app

# Switch to non-root user
USER appuser

# Expose the port your Express app uses
EXPOSE 3000

# Healthcheck hitting your /health route
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s \
  CMD wget --quiet --tries=1 --spider http://localhost:3000/health || exit 1

# Start your Express server
CMD ["node", "index.js"]
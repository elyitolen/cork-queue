FROM node:20-alpine

# Install build dependencies for better-sqlite3 and sharp
RUN apk add --no-cache python3 make g++ vips-dev

WORKDIR /app

# Install runtime deps
COPY package.json ./
RUN npm install --production

# Copy built server and frontend
COPY dist/ ./dist/

# Create uploads dir for extracted wine images
RUN mkdir -p uploads

EXPOSE 3000
ENV NODE_ENV=production
ENV PORT=3000

CMD ["node", "dist/index.cjs"]

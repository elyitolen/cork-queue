FROM node:20-alpine

# Install build dependencies for better-sqlite3 and sharp
RUN apk add --no-cache python3 make g++ vips-dev

WORKDIR /app

# Copy package files and install runtime deps
COPY package.json ./
RUN npm install --production

# Copy built app
COPY dist/ ./dist/
COPY uploads/ ./uploads/ 2>/dev/null || mkdir -p uploads

EXPOSE 3000

ENV NODE_ENV=production
ENV PORT=3000

CMD ["node", "dist/index.cjs"]

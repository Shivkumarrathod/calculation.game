# =========================
# Stage 1: Build Frontend
# =========================
FROM node:20-alpine AS frontend-builder

WORKDIR /app/client

# Install frontend dependencies
COPY client/package*.json ./
RUN npm ci

# Copy frontend source
COPY client/ ./

# Build frontend
RUN npm run build


# =========================
# Stage 2: Build/Prepare Backend
# =========================
FROM node:20-alpine AS backend

WORKDIR /app

# Install backend dependencies
COPY package*.json ./
RUN npm ci --omit=dev

# Copy backend source
COPY server.js ./

# Copy frontend build from Stage 1
COPY --from=frontend-builder /app/client/dist ./client/dist

# =========================
# Run Application
# =========================
EXPOSE 3000

CMD ["node", "server.js"]
